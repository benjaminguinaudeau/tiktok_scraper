from TikTokApi import TikTokApi
import argparse
import json
import os as os
from datetime import datetime

folder = str(datetime.today().strftime('%Y%m%d_%H_%M_%S'))


api = TikTokApi()

cli = argparse.ArgumentParser()
cli.add_argument("-q", "--username", required=True, help="Specify username")
cli.add_argument("-n", "--number", help="Number of results to return")

args = cli.parse_args()

def get_usernames(username, n):
  """get_usernames"""
  tiktoks = api.byUsername(username, count=n)
  
  #tiktok_list = []
  #for tiktok in tiktoks:
  #  tiktok_list.append(tiktok)
  
  return(tiktoks)

usernames = args.username.split(",")

os.mkdir(folder)

for username in usernames:
  print(username)
  data = get_usernames(username, int(args.number))
  
  with open(folder + '/' + username +'.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)


