#!/usr/bin/python
import dropbox
import datetime
import os
import time

def upload(dbx, fullname, subfolder, overwrite=False):
    """Upload a file.
    Return the request response, or None in case of error.
    """
    mode = (dropbox.files.WriteMode.overwrite
                    if overwrite
                    else dropbox.files.WriteMode.add)
    mtime = os.path.getmtime(fullname)
    path = constructPath(fullname, subfolder)

    with open(fullname, 'rb') as f:
        data = f.read()
        f.close()
        try:
            res = dbx.files_upload(
                    data, path, mode,
                    client_modified=datetime.datetime(*time.gmtime(mtime)[:6]),
                    mute=True)
        except dropbox.exceptions.ApiError as err:
                print('*** API error', err)
                return None
    return res

def getSharedLink(dbx, full_path):
    try:
        link = dbx.sharing_create_shared_link(full_path).url
    except dropbox.exceptions.ApiError as err:
        print('*** API error', err)
        return None
    return link

def constructPath(fullname, subfolder):
    path = '%s/%s' % ("/", subfolder.replace(os.path.sep, '/'))
    while '//' in path:
        path = path.replace('//', '/')

    try:
        name = os.environ["FILE_NAME"]
        path += name
        extension = os.path.splitext(fullname)
        path += extension[1]
    except KeyError as err:
        name = os.path.basename(fullname)
        path += '/%s' % (name)
    return path

def main():
    token = os.environ["TOKEN"]
    dbx = dropbox.Dropbox(token)
    fullname = os.environ["FILE_PATH"]
    subfolder = os.environ["DEST_PATH"]
    path_returned = upload(dbx, fullname, subfolder).path_lower
    shared_link = getSharedLink(dbx, path_returned)
    print shared_link
    return shared_link

main()
