---
title: "Extract information with encoding in R 🔡"
author: 'Andrés Felipe Insuasty Ch.'
date: '2021-04-03'
slug: Extract information with encoding
categories: ["Extract information"]
tags: ["Encoding"]
---

## *Are you a non English R user?*

In my case, Spanish language has the following letters: á, é, í, ó, ú, ü and ñ. This letters are saved different depending on the encoding (computation language) of the table you are extracting the data. And reading them might cause some headaches.

### Tips 💡

1.  To avoid having strange characters when reading the previews letters, make sure you are extracting the data with the same encoding of the table from your database (check properties of the table) or excel file. 💱

2.  Choose the correct option in the parameter encoding when reading the data.✔️

*For database*, when you are establishing connection, use the encoding of the table **`con<-DBI::dbConnect(odbc::odbc(),"Nombre_odbc",encoding="Latin1")`**

If different tables from the database use different encoding, use a different *con* when using `DBI::dbgetquery(con, glue::glue("..."))`

For excel, good news! `readxl::read.xlsx` identifies the encoding by itself and bring the information correctly.

For csv or txt files . Use file encoding parameter when using the read function.

3.  Encoding also apply when you are writing in R. Save the file with encoding utf8 and open with Latin1 might provoke different characters, then, reopen the file with the same encoding that was saved.

Last tip for Spanish users: Most common encoding for Spanish language are UTF-8 , Latin1 and ISO 8859-1

Hope this tips help you in your daily work. It took some mistakes when presenting or errors that i have to deal with workarounds while i found the real and easy way of working with. 👏
