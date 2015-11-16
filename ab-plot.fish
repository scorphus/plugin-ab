function ab-plot -a i -a o -d "Draw a plot from an AB gnuplot file"
  set argn (count $argv)

  contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: ab-plot [ab-data.tsv] [ab-plot.jpg]"
    return 0
  end

  test $argn -ge 1; or set i "ab-data.tsv"  # input TSV
  test $argn -ge 2; or set o "ab-plot.jpg"  # output JPG

  set p "
# Copied from http://www.bradlanders.com/2013/04/15/apache-bench-and-gnuplot-youre-probably-doing-it-wrong/
# Let's output to a jpeg file
set terminal jpeg size 930,930
# This sets the aspect ratio of the graph
set size 1, 1
# The file we'll write to
set output '$o'
# The graph title
set title 'Benchmark testing'
# Where to place the legend/key
set key left top
# Draw gridlines oriented on the y axis
set grid y
# Label the x-axis
set xlabel 'requests'
# Label the y-axis
set ylabel 'response time (ms)'
# Tell gnuplot to use tabs as the delimiter instead of spaces (default)
set datafile separator '\t'
# Plot the data
plot '$i' every ::2 using 5 title 'response time' with lines
exit
"

  echo $p | gnuplot

end
