    #include <stdio.h>
    int a1; b2; // error
    /*
	This is a Lexical error because the semi-colon breaks up the statement and doesn't leave b2 with a type.
	When the tokens are split up, there will be no match to b2.
    */

    int arr[10]  //error
    /*
	This is a Lexical error because there is no semi-colon, which in C indicates the end of a line, so it
	will merge the next line's content and cause errrors. The system has no way to continue as it will see
	invalid characters, [ and ], without defining the variable name.
	Cite: https://stackoverflow.com/questions/3484689/what-is-an-example-of-a-lexical-error-and-is-it-possible-that-a-language-has-no
    */
    long f#r, nx; //error
    /*
	This is a Syntactical error because there is a subset of characters C allows for variable names, and # is not 
	included in the grammar for those names.
    */
    int a = 99;


    int main (void){
          int do ;  //error
          /*
			This is a Lexical error because 'do' is a reserved word in C and cannot be used as a variable name.
          */
          int x;
          arr[1] = x;  //error
          /*
			This is a Static Semantic error because variable 'x' was never assigned before being used.
          */
          do = chg(a); //error
          /*
			This is a Lexical error because do is still a reserved word in C and cannot be a variable name.
			This is an extension of the error from above. This could also be a Syntactical error as 'do' cannot
			be set to a value, it's an operation word

			In addition, chg was not defined in the scope of C currently. Since there was no header, this has no direct
			reference and is a Syntactical error.
          */

          return do; //error
          /*
			This is a Lexical error because do is reserved in C and cannot be a variable name
		  */
    }

    int chg(long  fr)  {
         if (fr = 0) {  //error
         	/*
			The if statement is a syntactical error because the = operation returns the value that was set
			which would be 0 here (if this was in additional parenthesis), but the user meant to check if
			the fr was equal to 0 already.
         	*/
               x = 10; //error
               /*
				This is a Syntactical error because x was not defined in the chg scope so the type cannot
				be determined in C.
               */
               a = 10;
               arr[a] = 10; //error
               /*
                This is an Uncheckable error because you are indexing an array in C, but not in a safe way
                so you can go out of bounds by accident. Unlike Java, which throws an exception, C does not
                here and you will create undefined behavior.
               */
            } else {
               arr[1] = 1; //error
               /*
				This is a Lexical error because there is no closing bracket for the else loop, which causes
				the return to only occur in the else block. It makes no sense for a function to return an 
				int and have no return statement that is guarenteed to execute. 
               */
           
        return arr[1];
    }

