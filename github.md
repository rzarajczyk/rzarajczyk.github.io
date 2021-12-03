# Using multiple SSH keys in GitHub

## 1. Generate new SSH key
```
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```
## 2. Add PUBLIC key to Github
See [official GitHub tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## 3. Modify ~/.ssh/config

`~/.ssh/config`
```
Host github.com-rzarajczyk
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key1>
```
User MUST be `git`

## 4. Set the appropriate origin url
```
# Check current origin URL
git config --get remote.origin.url
> https://github.com/rzarajczyk/break-time.git

# Remove origin URL
git remote remove origin

# Add new origin URL
git remote add origin github.com-rzarajczyk:/rzarajczyk/break-time.git 
```
