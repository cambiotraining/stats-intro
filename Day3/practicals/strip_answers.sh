# This takes a source file and generates the corresponding question and answer files.
cat linear_R_source.Rmd | grep -v "## ANSWER ##" > linear_R_questions.Rmd
cat linear_R_source.Rmd | sed  "s/## ANSWER ##//" | grep -v "# Put.*!" > linear_R_answers.Rmd

cat multiple_R_source.Rmd | grep -v "## ANSWER ##" > multiple_R_questions.Rmd
cat multiple_R_source.Rmd | sed  "s/## ANSWER ##//" | grep -v "# Put.*!" > multiple_R_answers.Rmd

