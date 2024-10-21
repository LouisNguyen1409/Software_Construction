echo "Test 3 status changes staged for commit:"
touch a
./grip-init > /dev/null 2>/dev/null
./grip-add a > /dev/null 2>/dev/null
./grip-commit -m "Initial commit" > /dev/null 2>/dev/null
echo "Hello" > a
./grip-add a > /dev/null 2>/dev/null
./grip-status > program_output.log 2>stderr_a.log
rm -f a
rm -rf .grip

touch a
2041 grip-init > /dev/null 2>/dev/null
2041 grip-add a > /dev/null 2>/dev/null
2041 grip-commit -m "Initial commit" > /dev/null 2>/dev/null
echo "Hello" > a
2041 grip-add a > /dev/null 2>/dev/null
2041 grip-status > expected_output.log 2>stderr_e.log
rm -f a
rm -rf .grip