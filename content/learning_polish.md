---
slug: learning-polish
title: "Learning Polish language"
---

Is Polish difficult?
It migth be, but when you have a goal declared for 2022, you find the best and
fun way to do it. My goal for this 2022 is to communicate with my parents in law
in polish when they are visiting us in Colombia this june 2022.

How will I make ?
I will practice speaking with my girlfriend Klaudia.
I will learn vocabulary using R.

`starting_date <- "2022-01-14"`


```
## $greetings
## [1] "cześć"       "pa"          "dzien dobry" "dobranoc"    "dowidzenia" 
## 
## $food
##  [1] "chleb"      "jablko"     "mleko"      "kabanos"    "sok"       
##  [6] "kapusta"    "pomarancza" "ciasto"     "kawa"       "woda"      
## [11] "wódka"     
## 
## $animals
## [1] "pies"      "kot"       "biedronka"
## 
## $most_used
## [1] "nie"             "tak"             "dziekuje"        "prosze"         
## [5] "troszke/ troche" "Przepraszam"     "drogo"          
## 
## $tranportation
## [1] "samochód" "lot"      "metro"    "autobus"
```

- Number of learned by category: ```{r echo=FALSE} purrr::map(words_learned, length) %>% unlist()```

- Total words learned: `{r echo=FALSE} purrr::map(words_learned, length) %>% unlist() %>% sum()`


