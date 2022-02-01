# Reaver-wpc-maker-and-pingen-3W-Offline-

Reaver wpc session file maker, with MAC numers and 3W Offline pingen algorithms.

Primally we filter the network.
wash -i <iface>

Enter accordingly -> Choose vendor from the list (multiple vendors can be used).
<BSSID> <Vendor> <Vendor>
exaple:
1A:2B:3C:4D:5E:6F Realtek D-Link
  
Opened 3W Offline browser -> CLICK Get All and copy

From now everything happens automatically...
Multiple MACs can be developed one after the other.

---------------------------------------------------
Install:

git clone https://github.com/OutsiderLost/Reaver-wpc-maker-pingen.git

cd Reaver-wpc-maker-pingen

unzip 3W_wps-pin_offline.zip # && rm 3W_wps-pin_offline.zip && chmod +x *.sh

(run)
./wpc-maker.sh
