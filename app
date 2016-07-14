#!/usr/local/bin/python
import dropbox
import datetime
import os
import time
import sys

def upload(dbx, data, path, overwrite=False):
    """Upload a file.
    Return the request response, or None in case of error.
    """
    mode = (dropbox.files.WriteMode.overwrite
                    if overwrite
                    else dropbox.files.WriteMode.add)

    try:
        res = dbx.files_upload(data, path, mode)
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

def main(*args):

    tempFile = ''.join(sys.stdin.readlines())
    token = os.environ["TOKEN"]
    dbx = dropbox.Dropbox(token)
    dest_path = os.environ["FILE"]
    path_returned = upload(dbx, tempFile, dest_path).path_lower
    shared_link = getSharedLink(dbx, path_returned)
    print shared_link
    return shared_link

main()
