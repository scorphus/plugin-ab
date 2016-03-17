function ab-bench -a url -a n -a c -d "Benchmarch an application with AB"
  set argn (count $argv)

  test $argn -lt 1; or contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: ab-bench url [requests] [concurrency] [other-options...]"
    return 0
  end

  test $argn -ge 2; and test $n -ge 1; or set n 200  # requests
  test $argn -ge 3; and test $c -ge 1; or set c 2    # concurrency

  set options "-n" $n "-c" $c

  test $argn -ge 4; and set options $options $argv[4..-1];
  contains -- "-g" $options; or set options $options "-g" "ab-data.tsv"

  echo ab $options $url
  ab $options $url
end
