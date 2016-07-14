## Dropbox Babl Module

This is a module to post your file to Dropbox and returns a shared link

### How to use it?

Just like any other babl module, you need to install babl on your computer first. Check out this [Get Started](https://babl.sh/get-started) by babl.sh

Then you need to get a token from Dropbox to upload file to your own Dropbox account. Check out [this blog post](https://blogs.dropbox.com/developers/2014/05/generate-an-access-token-for-your-own-account/).

When you have the token for your account, here's how to use the babl module

```
cat ~/somefile.jpg | babl omnisyle/dropbox -e TOKEN="your_token" -e FILE="/path/to/file.jpg"

### return shared link
### => https://........
```
