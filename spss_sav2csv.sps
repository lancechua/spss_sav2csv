* Encoding: UTF-8.
begin program python3.

import spss
import os

# absolute path reference to avoid python set up differences
src_dir = r'C:\sav files'
out_dir = r'C:\sav files\csv'
os.chdir(src_dir)

sav_files = [f for f in os.listdir() if f[-4:] == '.sav']

read_cmd=r'''
GET
  FILE= '%s\%s'.
DATASET NAME DataSet%s WINDOW=FRONT.
'''

export_cmd=r'''
SAVE TRANSLATE OUTFILE='%s\%s.csv'
  /TYPE=CSV
  /ENCODING='UTF8'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.
DATASET CLOSE DataSet%s.
'''

# stream files to reduce memory impact
ctr = 1
for f in sav_files:
	spss.Submit(read_cmd % (src_dir, f, ctr))
	spss.Submit(export_cmd % (out_dir, f[:-4], ctr))
	ctr+=1
end program.
