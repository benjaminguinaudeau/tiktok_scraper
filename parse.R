from_unix <- function(x) {
  as.POSIXct(as.numeric(x), origin = '1970-01-01', tz = 'UTC')
}

is_unpackable <- function(x) {
  is.list(x) & length(x) == 1
}

is.not.dataframe <- function(x){
  !is.data.frame(x)
}

is.not.list <- function(x){
  !is.list(x)
}

run_hashtags <- function(hashtags, n) {
  system(glue::glue("python get_hashtags.py --hashtag {hashtags} --number {n}"))
}

run_usernames <- function(usernames, n) {
  system(glue::glue("python get_usernames.py --username {usernames} --number {n}"))
}


parse_tiktok <- function(file) {
  
  item_dat_raw <- file %>% 
    pull(itemInfos) 
  
  video_dat_raw <- item_dat_raw %>% 
    pull(video) %>% 
    unnest(urls) 
  
  video_meta <- video_dat_raw %>% pull(videoMeta)
  
  video_dat_raw <- video_dat_raw %>% 
    select(-videoMeta)
  
  
  video_dat <- video_dat_raw %>% bind_cols(video_meta)
  
  item_dat <- item_dat_raw %>% 
    mutate_if(is_unpackable, ~as.character(.x)) %>% 
    select_if(is.not.dataframe) %>% 
    rename(userId = authorId) %>% 
    bind_cols(video_dat)
  
  author_dat <- file %>% 
    pull(authorInfos) %>% 
    select_if(is.not.list)  
  
  music_dat <- file %>% 
    pull(musicInfos) %>% 
    select_if(is.not.list)
  
  author_stats <- file %>% 
    pull(authorStats) %>% 
    rename_all(~paste0("author_", .))
  
  tiktok_dat <- item_dat %>% 
    left_join(author_dat, by = "userId") %>% 
    left_join(music_dat, by = "musicId") %>% 
    bind_cols(author_stats)
  
  return(tiktok_dat)
}

