pacman::p_load(tidyverse)

# Sys.sleep(60*60*12)

source("parse.R")


c("plandemic","plannedemic",
  "billgatesisevil","scamdemic",
  "arrestbillgates","firefauci",
  "event201","id2020", "plandemic2020",
  "coronalies", "saynotobillgates",
  "coronafake", "fakevirus", "stopbillgates", 
  "qarmy", "adrenochrome", "pizzagate",
  "qanon", "nwo", "fearmongering",
  "illuminati") %>% 
  paste0(collapse = ",") %>% 
  run_hashtags(500)

