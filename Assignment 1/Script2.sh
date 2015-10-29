HOST=130.14.250.13
USER=anonymous          
PASS=jainash@iupui.edu   

# Call 1. Uses the ftp command with the -inv switches.  -i turns off interactive prompting. -n Restrains FTP from attempting the auto-login feature. -v enables verbose and progress.  
ftp -inv $HOST << EOF  

user $USER $PASS 
 
bye 
EOF