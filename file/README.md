# file
The post Z000000 /../../../../file/file_upload is a edge case.
This part of the code is handled manually.
One of the coreZ00/post.sh is used to created the
file/file_upload/coreZ00/post.sh.
To keep the consistency, if changes are made to coreZ00/post.sh
in the future, it is encouraged to port it here again.
* file_upload.sh LDIFFile: upload the LDIF file to a holding area
	* This holding area is actually under
	* the ~/../management-ui/upload of the dsa user
	* file_upload.sh checks curl version as older curl
	* does not work.
