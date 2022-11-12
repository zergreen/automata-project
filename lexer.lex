%%
%class Lexer
%public
%unicode
%standalone

%{
    String[] symTable = new String[101];
    int countIden = 0;
%}



LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = 0 | [1-9][0-9]*

%%

<YYINITIAL>{

    "+"|"-"|"*"|"/"|"="|">"|">="|"<"|"<="|"=="|"++"|"--"
    {
    System.out.println("OPERATOR: "+yytext());
    }

    "("|")"|";"
    {
        if(yytext().equals(";"))
            System.out.println("SEMICOLON: ;");
        else
            System.out.println("PARENTHESE: "+yytext());
    }

    "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
    {
        System.out.println("KEYWORDS: "+yytext());
    }

    {DecIntegerLiteral}{Identifier}
    {
        System.out.println("ERROR: "+yytext());
        System.exit(0);
    }

    {DecIntegerLiteral}
    {
        System.out.println("INTEGER: "+yytext());
    }

    {Identifier}
    {
        String newIden = yytext();
        boolean check = false;
        for(int i=0;i<countIden;i++){
                // System.out.println("Index is : "+i);
                 if(newIden.equals(symTable[i])){
                    check = true;
                    break;
                }                
        }
        if(check){
            System.out.printf("IDENTIFIER \"%s\" ALREADY IN SYMBOL TABLE\n",newIden);
        }else{
            System.out.println("NEW IDENTIFIER: "+newIden);
            symTable[countIden++] = newIden;
        }

    }

    \"{InputCharacter}*\"
    {
         System.out.println("String: "+yytext());
    }

    {Comment}
    { }

    {WhiteSpace}
    { }

    .
    {
        System.out.println("ERROR: "+yytext());
        System.exit(0);
    }
}
