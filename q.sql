SELECT (score(1)*6+score(2)*3+score(3)), photo_id,subject,place, description 
FROM IMAGES
WHERE (contains(SUBJECT, 'AD', 1) > 0 OR contains(PLACE, 'AD', 2) > 0  OR contains(description, 'AD', 3) > 0) 
AND ('admin'='NI' or owner_name='ni' OR permitted = 1 OR 'ni' in(select friend_id from group_lists where permitted=group_id ) )
AND timing<to_date('2019-09-07 ','yyyy-mm-dd') and timing>to_date('2010-09-07 ','yyyy-mm-dd')
order by (score(1)*6+score(2)*3+score(3)) desc
