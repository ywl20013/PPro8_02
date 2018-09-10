# ppro8_01

# create a new repository on the command line
1. git init
2. git add README.md
3. git config --global core.excludesfile ~/.gitignore
4. git commit -m "first commit"
5. git remote add origin https://github.com/ywl20013/pprop8_02.git
6. git push -u origin master

# push an existing repository from the command line
1. git remote add origin https://github.com/ywl20013/pprop8_02.git
2. git push -u origin master

#
1. cmd cd.>.git-credentials
2. git config credential.helper store
3. [credential]
	helper = store --file .git-credentials  
	helper = store