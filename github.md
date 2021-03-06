# Using multiple SSH keys in GitHub

## 1. Generate new SSH key

```shell
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

## 2. Add PUBLIC key to Github

See [official GitHub tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## 3. Modify ~/.ssh/config

`~/.ssh/config`

```text
Host github.com-rzarajczyk
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key1>
```

User MUST be `git` (in case of GitHub)

## 4. Set the appropriate origin url

```shell
# Check current origin URL
git config --get remote.origin.url
> https://github.com/rzarajczyk/break-time.git

# Remove origin URL
git remote remove origin

# Add new origin URL
git remote add origin github.com-rzarajczyk:/rzarajczyk/break-time.git 
```

## 5. Set the appropriate user.name and user.email in the current repo

```shell
git config user.email "your_email@example.com"
git config user.name "Your Name"
```

Note: if you struggle with remembering if you have entered correct user.name and user.email in each of your repos, I
recommend adding this information into command propmpt -
see [Agnoster Theme with Git user display](macos-setup.md#agnoster-theme-with-git-user-display)
