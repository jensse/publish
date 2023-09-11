# publish

Generic frame to use  https://github.com/kovetskiy/mark with github actions.


## How do it work

The script ''' ./bin/publish.sh ''' runs on every commit.  make sure all chect that all tools are available. find the *.md file in src directory, and publish them.



## Configuration file

Passwors are loaded as secrets in the MARKFILE variable, in guthub secrets. If not on your local/private computer. then it just check if mark is available.

Filname: ''' ~/.config/mark '''

### Filcontent

'''
username = "your username here"
password = "your password here"
base_url = "https://<your site here>.atlassian.net/wiki
'''
