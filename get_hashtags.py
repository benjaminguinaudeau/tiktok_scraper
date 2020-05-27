from TikTokApi import TikTokApi
import argparse
import json
import os as os
from datetime import datetime

folder = str(datetime.today().strftime('%Y%m%d_%H_%M_%S'))


api = TikTokApi()

cli = argparse.ArgumentParser()
cli.add_argument("-q", "--hashtag", required=True, help="Specify hashtag")
cli.add_argument("-n", "--number", help="Number of results to return")

args = cli.parse_args()

def get_hashtags(hashtag, n):
  """get_hashtags"""
  tiktoks = api.byHashtag(hashtag, count=n)
  
  #tiktok_list = []
  #for tiktok in tiktoks:
  #  tiktok_list.append(tiktok)
  
  return(tiktoks)

hashtags = args.hashtag.split(",")

os.mkdir(folder)

for hashtag in hashtags:
  print(hashtag)
  data = get_hashtags(hashtag, int(args.number))
  
  with open(folder + '/' + hashtag +'.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)


