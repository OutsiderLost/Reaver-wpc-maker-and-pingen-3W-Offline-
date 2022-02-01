#!/bin/bash

echo " "
echo "Opened new terminal !!!"
echo " "
echo "Write traget MAC and save -> <BSSID> <Vendor> <Vendor>"
echo " "
echo "Choose from the Vendor examples:"
echo " "
cat choose-vendor.txt
echo " "

mkdir result

qterminal -e nano result/MAC-Vendor.txt

sed "s/XX:XX:XX:XX:XX:XX/$(cut -d ' ' -f 1 result/MAC-Vendor.txt)/g" 3W_wps-pin_Firefox/'3WiFi WPS PIN generatorFIREFOX.html' > 3W_wps-pin_Firefox/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').html"

echo " "
echo "Opened new terminal and browser !!!"
echo " "
echo "Copy MAC PIN algorithms and save -> CLICK Get All !!!"
echo " "

firefox 3W_wps-pin_Firefox/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').html" | qterminal -e nano result/MAC-PIN-alg.txt

mkdir working

cut -d ' ' -f 2- result/MAC-Vendor.txt | sed 's/ /\n/g' | sed -e '/^[[:space:]]*$/d' -e 's/[ ]//g' | sort -u | sed "s/.*/-e 's\/&\/GRABBING\/g'/" | paste -d" " -s | sed "s/.*/sed &/" > working/sedcommand-01.sh

echo " "
echo "Remaining process logging......"
echo " "
echo "Vendor main PINs ----------------"
# Vendor main PINs ----------------
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/!d' -e '/^[[:space:]]*$/d' | cut -c 1-4 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-4_01.txt
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/!d' -e '/^[[:space:]]*$/d' | cut -c 5-7 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-3_01.txt
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/!d' -e '/^[[:space:]]*$/d' | cut -c 1-8 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-PIN_01.txt

echo "General main PINs ---------------"
# General main PINs ---------------
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/d' -e '/^[[:space:]]*$/d' | cut -c 1-4 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-4_02.txt
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/d' -e '/^[[:space:]]*$/d' | cut -c 5-7 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-3_02.txt
bash working/sedcommand-01.sh < result/MAC-PIN-alg.txt | sed -e '/^[0-9]\{8\}/!d' -e '/GRABBING/d' -e '/^[[:space:]]*$/d' | cut -c 1-8 | cat -n | sort -uk2 | sort -nk1 | cut -f2- > working/main-PIN_02.txt
# ( delete duplicates, no sorting order, another method -> perl -ne 'print if ++$k{$_}==1' )


echo "MAC numbers after writting --- Vendor main 4 ---"
# (main 4)
# MAC numbers after writting --- Vendor main 4 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-4_01.txt > working/AfterWrite-4_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-4_01.txt >> working/AfterWrite-4_01.txt
echo "MAC numbers after writting --- General main 4 ---"
# MAC numbers after writting --- General main 4 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-4_02.txt >> working/AfterWrite-4_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-4_02.txt >> working/AfterWrite-4_01.txt

echo "MAC numbers after writting --- Vendor main 3 ---"
# (main 3)	
# MAC numbers after writting --- Vendor main 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-3_01.txt > working/AfterWrite-3_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-3_01.txt >> working/AfterWrite-3_01.txt
echo "MAC numbers after writting --- General main 3 ---"
# MAC numbers after writting --- General main 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-3_02.txt >> working/AfterWrite-3_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-3_02.txt >> working/AfterWrite-3_01.txt

# (main PIN 8)
echo "MAC numbers after writting --- Vendor main PIN 8 ---"
# MAC numbers after writting --- Vendor main PIN 8 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-PIN_01.txt > result/AfterWrite-PIN.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-PIN_01.txt >> result/AfterWrite-PIN.txt
echo "MAC numbers after writting --- General main PIN 8 ---"
# MAC numbers after writting --- General main PIN 8 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/main-PIN_02.txt >> result/AfterWrite-PIN.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/main-PIN_02.txt >> result/AfterWrite-PIN.txt

echo "(hashcat outfiles) ---"
# (hashcat outfiles)
# 4 mask ---
hashcat -a 3 ?d?d?d?d --stdout > working/4hc-mask.txt
# 3 mask ---
hashcat -a 3 ?d?d?d --stdout > working/3hc-mask.txt

echo "MAC numbers after writting --- hc mask 4 ---"
# MAC numbers after writting --- hc mask 4 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/4hc-mask.txt > working/AfterWrite-4_02.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/4hc-mask.txt >> working/AfterWrite-4_02.txt
echo "MAC numbers after writting --- hc mask 3 ---"
# MAC numbers after writting --- hc mask 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/!d" working/3hc-mask.txt > working/AfterWrite-3_02.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g')]/d" working/3hc-mask.txt >> working/AfterWrite-3_02.txt


echo "(sedcommand files) ---"
# (sedcommand files)
# 4 (02)
sed "s/.*/-e '\/&\/d'/" working/AfterWrite-4_01.txt | paste -d" " -s | sed "s/.*/sed &/" > working/sedcommand-02.sh
# 3 (03)
sed "s/.*/-e '\/&\/d'/" working/AfterWrite-3_01.txt | paste -d" " -s | sed "s/.*/sed &/" > working/sedcommand-03.sh

echo "(bash 4) ---"
# (bash 4)
bash working/sedcommand-02.sh < working/AfterWrite-4_02.txt | sed -e '/^[[:space:]]*$/d' -e 's/[ ]//g' > working/AfterWrite-4_02cut.txt
echo "(bash 3) ---"
# (bash 3)
bash working/sedcommand-03.sh < working/AfterWrite-3_02.txt | sed -e '/^[[:space:]]*$/d' -e 's/[ ]//g' > working/AfterWrite-3_02cut.txt

echo "backup 4 (01) ---"
# backup 4 (01)
cp working/AfterWrite-4_01.txt working/AfterWrite-4_01cp.txt
echo "backup 3 (01) ---"
# backup 3 (01)
cp working/AfterWrite-3_01.txt working/AfterWrite-3_01cp.txt

echo "continues under the lines 4 ---"
# continues under the lines 4
cat working/AfterWrite-4_02cut.txt >> working/AfterWrite-4_01cp.txt
echo "continues under the lines 3 ---"
# continues under the lines 3
cat working/AfterWrite-3_02cut.txt >> working/AfterWrite-3_01cp.txt
#--------------------------------------------------------

echo -e "0\n0\n0" > result/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').wpc"

cat working/AfterWrite-4_01cp.txt >> result/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').wpc"

cat working/AfterWrite-3_01cp.txt >> result/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').wpc"

# Unecessary file remove
rm 3W_wps-pin_Firefox/"$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').html"

# folders, file rename...
mv result/AfterWrite-PIN.txt result/"Main-PIN-$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g').txt"

mv working "working-$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g')"
mv result "result-$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed 's/://g')"

#-------------------------------------------------------
echo " "
echo "PROCESS END SUCCESS !!! :-)"
echo " "
echo "Final file to use -> result/... $(cut -d ' ' -f 1 result-*/MAC-Vendor.txt | sed 's/://g').wpc"
echo " "
echo "(copy to use -> cp *.wpc /var/lib/reaver/)"
echo " "
