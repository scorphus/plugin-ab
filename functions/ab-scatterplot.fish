function ab-scatterplot -a i -a o -d "Draw a scatterplot from an AB gnuplot file"
  set argn (count $argv)

  contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: ab-scatterplot [ab-data.tsv] [ab-scatterplot.jpg]"
    return 0
  end

  test $argn -ge 1; or set i "ab-data.tsv"         # input TSV
  test $argn -ge 2; or set o "ab-scatterplot.jpg"  # output JPG

  set p "
# Copied from http://www.bradlanders.com/2013/04/15/apache-bench-and-gnuplot-youre-probably-doing-it-wrong/
# Let's output to a jpeg file
set terminal jpeg size 1280,720
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
# Specify that the x-series data is time data
set xdata time
# Specify the *input* format of the time data
set timefmt '%s'
# Specify the *output* format for the x-axis tick labels
set format x '%S'
# Label the x-axis
set xlabel 'seconds'
# Label the y-axis
set ylabel 'response time (ms)'
# Tell gnuplot to use tabs as the delimiter instead of spaces (default)
set datafile separator '\t'
# Plot the data
plot '$i' every ::2 using 2:5 title 'response time' with points
exit
"

  echo $p | gnuplot

end
