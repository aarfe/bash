# Select which files should be changed
for FILE in csc_customer_feedback_*_ENV.py; 
do 
echo $FILE

# Add line after a specific line, first check that the line exists, so we do not duplicate the same line
grep -q -e 'survey_title = "FEED_" + COUNTRY' ${FILE} || sed -i '/t2 = datetime.strftime(now, date_format)/a survey_title = "FEED_" + COUNTRY' ${FILE};
# Add comma at the end on one line. Check also if change is already in place 
grep -q -e '    "t2": t2,' ${FILE} ||  sed -i '/\    "t2": t2/ s/$/,/' ${FILE};
# Add line after a specific line, first check that the line exists, so we do not duplicate the same line
grep -q -e '    "survey_title": survey_title' ${FILE} || sed -i '/\    "t2": t2/a\    "survey_title": survey_title' ${FILE};
done;
