# It expects to receive the input from the stdin and extract the lastError value in the Chronos json for a specific job whose name is in the arguments
sed -e 's/[{}]/''/g' |  awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}'  | grep '^"lastError"\|^\[*"name"' | grep -A1 -e '"name":"$1"' | grep -e '^"lastError"' | sed -e 's/"lastError":\(.*\)$/\1/'

