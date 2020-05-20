

#' get the phone info from fp
#'
#' @param addrPhone addrphone
#'
#' @return phone
#' @export
#'
#' @examples
#' get_fp_phone()
get_fp_phone <- function(addrPhone) {
  addrPhone <- tsdo::na_replace(addrPhone,'')
  phone <- tsdo::getPhoneNumber(addrPhone)
  phone <- tsdo::na_replace(phone,'')
  return(phone)


}

#' get the fp addr
#'
#' @param addrPhone  phoneNumber
#'
#' @return return address
#' @export
#'
#' @examples
#' get_fp_addr
get_fp_addr <- function(addrPhone){
  phone <- get_fp_phone(addrPhone)
  df_addrPhone <- data.frame(addrPhone,phone,stringsAsFactors = F)
  new_data <- tsdo::df_left(df_addrPhone,'addrPhone','phone','address')
  res <- new_data$address
  return(res)
}

#' get the fp bankinto
#'
#' @param bankNumber bankno
#'
#' @return bank
#' @export
#'
#' @examples
#' get_fp_bank()
get_fp_bank <- function(bankNumber) {
  res <-lapply(bankNumber,function(txt){
    index = stringr::str_locate(txt,"\\d{2}")
    if(is.na(index)){
      idx <- 0
    }else{
      idx <-index[1]-1
    }
    bank <- tsdo::left(txt,idx)
    return(bank)


  })
  res <- unlist(res)
  return(res)

}

#' get the acctNumber from fp
#'
#' @param bankNumber bank number
#'
#' @return acctNumber
#' @export
#'
#' @examples
#' get_fp_acctNumber()
get_fp_acctNumber <- function(bankNumber) {
  bank <- get_fp_bank(bankNumber)
  df_bankNumber <- data.frame(bankNumber,bank,stringsAsFactors = F)
  new_data <- tsdo::df_right(data =df_bankNumber,var_txt = 'bankNumber',var_left = 'bank',var_right = 'acctNumber')
  res <- new_data$acctNumber
  return(res)

}


#' 处理发票信息
#'
#' @param file 发票文件名称
#'
#' @return 返回值
#' @export
#'
#' @examples
#' deal_fapiao()
deal_fapiao <- function(file="data-raw/fp.xlsx") {

  fp <-   readxl::read_excel(file)

  addrPhone <- fp$地址电话;
  addr <- get_fp_addr(addrPhone);
  phone <-get_fp_phone(addrPhone);
  bankNumber <- fp$银行账号;
  bank <- get_fp_bank(bankNumber);
  acctNumber <- get_fp_acctNumber(bankNumber);
  custName <- fp$名称
  taxNo <- fp$税号

  mydata <-data.frame(custName,taxNo,addr,phone,bank,acctNumber,stringsAsFactors = F)

 return(mydata)

}
