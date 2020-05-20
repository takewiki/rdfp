library(rdfp)

library(readxl)
fp <- read_excel("data-raw/fp.xlsx")

#dims <- dim(fp)

addrPhone <- fp$地址电话;
addr <- get_fp_addr(addrPhone);
phone <-get_fp_phone(addrPhone);
bankNumber <- fp$银行账号;
bank <- get_fp_bank(bankNumber);
acctNumber <- get_fp_acctNumber(bankNumber);
custName <- fp$名称
taxNo <- fp$税号

mydata <-data.frame(custName,taxNo,addr,phone,bank,acctNumber,stringsAsFactors = F)

View(mydata)

openxlsx::write.xlsx(mydata,'./test.xlsx')




