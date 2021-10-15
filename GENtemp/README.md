# GENtemp -- code gen template directory
The files here are in OPMarkUp.temp format.
The OP is a RestAPI operation including detete, get, post, and put.
The MarkUp is referring to a pattern of "Z[0|1]+",
where 0 indicates the position is a constant string within a RestAPI end point,
while 1 indicates the position is a variable.
These files are used as templates to create shell files that contain
curl commands to invoke the RestAPI.
