def numUniqueEmails(emails):
        """
        :type emails: List[str]
        :rtype: int
        """
        raw_emails = set()
        for email in emails:
            sp_at = email.split('@')
            pe_sp_add = sp_at[0].split('+')
            finalAddress = pe_sp_add[0].replace('.','') + sp_at[1]
            raw_emails.add(finalAddress)
        
        return len(raw_emails)


        

            


def main():

    nub = numUniqueEmails({"sss@123.com", "yyyy@456.com", "sss+123@123.com"})
    print(nub)


# 执行
main()
