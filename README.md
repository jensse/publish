# publish

Generic project to use with https://github.com/kovetskiy/mark along with GitHub actions.


## How do it WORKS



'''.github/workflows/publish.yml''' set the script in '''bin/publish.sh''' to executable, and run the script.

The '''bin/publish.sh''' runs on every commit.  And use '''find''' to find all markdown files ''' *.md* ''' with a minimum search-depth of 4 (leaving place for generic files in the file-space below includes etc... ).

The lack of error-checking is a trade-off: Readability, and transparency is priority.

## GitHub-variables used

''' ${GITHUB_WORKSPACE} ''' Root og filsystem wher everything happens.
''' ${MARKFILE} ''' the local representation of your GitHub secrets containing your credentials as statet in the env section: ''' MARKFILE: ${{ secrets.MARKFILE }} '''


## Configuration file

Passwors are loaded as secrets in the MARKFILE variable and written .markfile at the root of working dir. The file is equivialent to ''' ~/.config/mark ''' if running localy.

### Filcontent

'''
username = "your username here"
password = "your password here"
base_url = "https://<your site here>.atlassian.net/wiki
'''
