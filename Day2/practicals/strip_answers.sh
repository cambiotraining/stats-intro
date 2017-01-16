# This takes a source file and generates the corresponding question and answer files.
cat teaching_R_source.Rmd | grep -v "## ANSWER ##" | sed "s/## QUESTION ##//" > teaching_R_questions.Rmd
cat teaching_R_source.Rmd | grep -v "## QUESTION ##" | sed  "s/## ANSWER ##//" | grep -v "# Put.*!" > teaching_R_answers.Rmd

cat tests_R_source.Rmd | grep -v "## ANSWER ##" > tests_R_questions.Rmd
cat tests_R_source.Rmd | sed  "s/## ANSWER ##//" | grep -v "# Put.*!" > tests_R_answers.Rmd

