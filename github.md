# Using single/multiple SSH keys in GitHub

## Generate new SSH key

```shell
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```
Note: generated SSH key should have access rights:
```shell
chmod 600 ~/.ssh/<key>
```

## Adding PUBLIC key to Github

See [official GitHub tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## Single SSH key setup

`~/.ssh/config`

```text
Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key1>
```
And that's it, you can clone your private repo

## Multiple SSH keys setup

### Modify `~/.ssh/config`

`~/.ssh/config`

```text
Host github.com-rzarajczyk
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key1>
```

### Set the appropriate origin url

```shell
# Check current origin URL
git config --get remote.origin.url
> https://github.com/rzarajczyk/break-time.git

# Remove origin URL
git remote remove origin

# Add new origin URL
git remote add origin github.com-rzarajczyk:/rzarajczyk/break-time.git 
```

### Set the appropriate user.name and user.email in the current repo

```shell
git config user.email "your_email@example.com"
git config user.name "Your Name"
```

Note: if you struggle with remembering if you have entered correct user.name and user.email in each of your repos, I
recommend adding this information into command prompt -
see [Agnoster Theme with Git user display](macos-setup.md#agnoster-theme-with-git-user-display)
