# Using SSH keys in GitHub (single or multiple)

## Generating new SSH key

```shell
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```
Note: make sure the generated SSH key has correct access rights:
```shell
chmod 600 ~/.ssh/<key>
```

## Adding PUBLIC key to Github

See [official GitHub tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

Make sure you upload **PUBLIC** key!

## Single SSH key setup

Edit `~/.ssh/config` and put there the following content:
```text
Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key>
```

And that's it, you can clone your private repo

## Multiple SSH keys setup

### Modify `~/.ssh/config`

Edit `~/.ssh/config` and put there the following content:
```text
Host github.com-<name>
	HostName github.com
	User git
	IdentityFile ~/.ssh/<key>
```
Replace `<name>` with some unique name which will identify your accounts. It might be `account1`, but also f.ex. your username

### Set the appropriate origin url

In the git repository:
```shell
# Check current origin URL
git config --get remote.origin.url
> https://github.com/<repo-path>.git

# Remove origin URL
git remote remove origin

# Add new, modified origin URL
git remote add origin github.com-<name>:/<repo-path>.git 
```
Replace `<name>` with the name you put in your `~/.ssh/config` file

### Set the appropriate user.name and user.email in the current repo

If you want to override your username and email in the repository, you can do it: 

```shell
git config user.email "your_email@example.com"
git config user.name "Your Name"
```

Note: if you struggle with remembering if you have entered correct `user.name` and `user.email`
in each of your repos, I recommend adding this information into command prompt -
see [Agnoster Theme with Git user display](macos-setup.md#agnoster-theme-with-git-user-display)
