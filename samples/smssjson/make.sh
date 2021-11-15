#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
cd ../..
HOMEDIR=$(pwd)
. "$MYPATH"/env.shlib
cd "$MYPATH/${JSONDIR}"
JSON=$(bash make.sh)
cd "$HOMEDIR"
###
# Schema
# To add netegrity.dxc after the default.
# Limits
# 1.
# 2.
# 3. set the max-ops setting. The session store is not expected
#    to return more than 1,000 objects per search query
# 4. The multiwrite queue setting.
#    Set the queue to handle from 300,000 through 500,000 transactions.
#    The optimal value allows a normal reboot of one of the directory server
#    hosts without causing the multiwrite queue to fill.
# 5. Set the multi-write-outstanding-ops limits setting.
#    This setting gives the number of updates that 
#    a DSA send at one time, from its multiwrite queue to a recovering DSA
#    The recommenced value is 1000.
#    
# Server Section
# 1. set the right dsa name
# 2. In the #schema section,
# 3. In the #service limits section,
# 4. Set the set cache-index entry
# 5. (Optional) To store more session objects in memory,
#    compress the smVariableValue attribute using
#    set compress type=smVariableValue
#    server: set compress type=smVariableValue is optional
# 6. Ensure that the multi-write-disp-recovery setting is set to false
#    This session store does not need this recovery method.
# 7. (Optional) Disable transaction logging to improve performance.
# 8. (Optional) If session store DSAs are replicated,
#    add the dsp-idle-time setting to the DSA knowledge file
#
# Session Store Backup not required as it is transactional by nature
#    Q: How to recover a out-of-sync?
#
# Asynchronous Replication
#    The session store processes update requests at a high volume.
#    To optimize the replication across all the DSA session stores
#    including the local stores, set replication to asynchronous.s
#    Updates that are sent asynchronously free up threads so that
#    they can continue processing requests without waiting for validation.
#
# Performance
#    Considering Data Partitioning
#    Index only suggested attributes to save deletion time
#    Multiple Host for Data Partitioning
#    Give more memory than the data files to allow all data in memory
#    Disable tansaction-log
#    Use a single queue instead of one queue per thread
#
#    On SiteMinder Policy Server
#    Under registry
#       HKEY_L_M\SOFTWARE\Netegrity\SiteMinder\CurrentVersion\SessionServer
#    1. SessionUpdateGracePeriod
#       Effective idle timeout = idle timeout + SessionUpdateGracePeriod
#       default is 0x1
#       Use to save validating/updating session store too frequently
#    2. MaxConcurrentDeletes
#       Reduce this value if excessive deletion load on your session store.
#       The default is 0x19
#    3. MaintenanceQueryRowLimit
#       Specifies how many expired session records are deleted simultaneously.
#       Reduce this value if you have high delete/insert contention
#       against your session store.
#       The default value is 0x64
#    4. EnableFlushUserCmdOnLogout
#       whether users are flushed from the session store cache on logout.
#       1 to enable the parameter or 0 to disable the parameter.
#       If this registry key is not added, the users are not flushed.
###
if [ -z "$DBSIZE" ] ; then
  DBSIZE=$(echo "$JSON" | ./jq -r '.config.server."dxgrid-db-size"')
fi
echo "$JSON" | bash dsas/cleanse.sh | \
    ./jq -S --argjson c "$CACHEINDEX" --argjson d "$DSAFLAGS" \
      '.config.knowledge[0].prefix = "'${PREFIX}'"
      | .config.knowledge[0]."trust-flags" += [ "allow-check-password" ]
      | .config.server."dxgrid-db-size" = '"$DBSIZE"'
      | .config.schema += ["netegrity.dxc"] 
      | .config.limits."max-op-size" = 1000
      | .config.limits."multi-write-queue" = 300000
      | .config.limits."multi-write-outstanding-ops" = 1000
      | .config.server = { "cache-index" : $c } + .config.server
      | .config.server."lookup-cache" = true
      | .config.server."multi-write-disp-recovery" = false
      | .config.settings."disable-transaction-log" = true
      | .config.settings."disable-transaction-log-flush" = true
      | .config.knowledge[0]."dsp-idle-time" = 30
      | .config.knowledge[0]."dsa-flags" = $d
      | .config.settings."dxgrid-queue" = true
      '
