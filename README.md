## Dropbox Babl Module

This is a module to post your file to Dropbox and returns a shared link

### How to use it?

Just like any other babl module, you need to install babl on your computer first. Check out this [Get Started](https://babl.sh/get-started) by babl.sh

Then you need to get a token from Dropbox to upload file to your own Dropbox account. Check out [this blog post](https://blogs.dropbox.com/developers/2014/05/generate-an-access-token-for-your-own-account/).

When you have the token for your account, here's how to use the babl module

```
babl omnisyle/dropbox -e TOKEN="your_token" -e FILE_PATH="path_to_file_to_upload" -e DEST_PATH="destination_path_on_your_dropbox" -e FILE_NAME="optional_rename"

### return shared link
### => https://........
```
