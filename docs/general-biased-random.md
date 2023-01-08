---
comments: true
---
# Biased random algorithm

Choosing random elements from an array without repetitions is generally a typical programming task.
But what if we would like to have randomness, but with some influence on how this randomness works?

This is my solution for **the biased random problem** - choosing random
array elements, but with the possibility to define some elements of the array
as more or less likely to be chosen.

## Problem description

To be more precise, let's write a PHP function with the following structure:

``` php
<?php

function getMultipleBiasedRandomElements(array $array, array $biases, int $count) {
    // code here...
}

?>
```

where:

* `$array` is an array of any elements
* `$biases` is an array of floats, with the size equal to the size of `$array`. Each element of `$biases` should
  define the probability of choosing corresponding item from `$array`:
    * value 1.0 is a "typical" probability
    * positive values below 1.0 should reduce the probability of choosing the element
    * 0.0 should mean that the corresponding element in `$array` is impossible to be chosen
    * negative values are not allowed
    * values above 1.0 should increase the probability of choosing the corresponding element
* `$count` - is the number of elements to be chosen

Of course, **we can use a built-in functions** for randomness

### Example

* let `$array` be `['a', 'b', 'c', 'd']`
* let `$biases` be `[1.0, 0.5, 1.0, 3.0]`
* let `$count` be 2

In this case the function should choose `2` random elements from `['a', 'b', 'c', 'd']`,
but taking into account that:

* probability of choosing `b` is two times lower (factor 0.5) than `a` or `c`
* probability of choosing `d` if three times higher (factor 3.0) than `a` or `c`

### Real-life example

Some example of where can we use the biased random algorithm is the multiplication
table quiz app for primary school kids:

> The application should ask a few random question about the multiplication
> table and verify the student's answer.
>
> ![memo.png](resources%2Fmemo.png)
>
> The problem is that the multiplication table contains some very simple operations
> (like multiplying by `0`, `1` or `10`), but also some more difficult to remember (`7 * 8`)
> 
> Let's take a look:
>
> <table id="multiplication-table"></table>
> <span class="q-legend q-very-simple">very simple</span> - <span class="q-legend q-simple">simple</span> - <span class="q-legend q-difficult">difficult</span> 
>
> Of course, we can argue whether some operation is "simple", "very simple", "normal" or "difficult",
> but let's stick to the above definition for a while. In this case we can see, that there's
> more green than red in the table - **"simple" and "very simple" questions are majority,
> "difficult" - are minority**.
> 
> But **there's no point in asking lots of simple questions**. If we want kids to learn,
> the app should ask focus difficult operations, and only sometimes ask about the simple ones.
>
> This is where the biased random algorithm might be used. We could assign higher
> biases to "difficult" questions, making them more likely to be chosen, and 
> lower biases to the "simple" and "very simple" to make them less probable to be chosen.

## My solution

!!! question "Do you have a better idea?"

    This solution works, but maybe you have some better solution? Let me know!
    You can find contant information at [zarajczyk.pl](https://zarajczyk.pl)

This is my solution (see comments on the listing):

```php linenums="1"
<?php 

function random(): float {  #(1)!
    return mt_rand() / mt_getrandmax();
}

function getBiasedRandomIndex(array $biases): int { #(2)!
    /* example
    biases = [ 1.0, 0.5, 2.0, 1.25, 1.0 ]
    expected ranges = [0-1.0)[1.0-1.5)[1.5-3.5)[3.5-4.75)[4.75-5.75)
    */

    $rightRangeBordersExclusive = array();
    $border = 0.0;
    foreach ($biases as $bias) {
        $border += $bias;
        $rightRangeBordersExclusive []= $border;
    }

    $random = random() * $border;

    $index = 0;
    while ($random >= $rightRangeBordersExclusive[$index]) {
        $index++;
    }
    return $index;
}

function getMultipleBiasedRandomElements(array $array, array $biases, int $count) {
    if (count($array) <= $count) { #(3)!
        // nothing to select, just randomize the input array
        $copy = $array;
        shuffle($copy);
        return $copy;
    }
    $result = array();
    $arrayCopy = $array; #(4)!
    $biasesCopy = $biases;
    for ($i=0; $i<$count; $i++) { #(5)!
        $randomIndex = getBiasedRandomIndex($biasesCopy);
        $selectedElement = $arrayCopy[$randomIndex];
        $result []= $selectedElement;
        array_splice($arrayCopy, $randomIndex, 1);
        array_splice($biasesCopy, $randomIndex, 1);
    }
    return $result;
}

?>
```

1. PHP doesn't have a straightforward function to generate a random double between 0.0 and 1.0,
   so I have to define my own based on PHP build-in functions
2. This function requires more explanation, please take a look at the description below the listing
3. In this case we should choose the whole array, just randomize it
4. Unlike other languages - f.ex. Java - PHP passes arrays to functions by value (by copying them). So
   technically there's no need to additionally protect input arguments by creating an explicit copy.
   However, for the sake of readability (especially for the readers not familiar with PHP) I decided to put it here.
5. In a loop choose one random element from the copy of the input array, append it to the `$result` and then
   **remove** from the input array copy to avoid duplicates.

### How `getBiasedRandomIndex` works?

The most interesting part of this algorithm is the `getBiasedRandomIndex` function.
The main idea behind it is to create a range, which is split into parts of length
proportional to the biases (probabilities) of each array elements.

#### Example 1 - when biases are equal

* let `$array` be `['a', 'b', 'c', 'd']`
* let `$biases` all be equal -  `[1.0, 1.0, 1.0, 1.0]`

Then the range should look like this:

<div class="br-chart-element" style="width: 25%; background-color: #f2ca19;">a</div>
<div class="br-chart-element" style="width: 25%; background-color: #87e911;">b</div>
<div class="br-chart-element" style="width: 25%; background-color: #ff00bd;">c</div>
<div class="br-chart-element" style="width: 25%; background-color: #88c6ed;">d</div>

Now if we pick a random point from this range (using a normal, unbiased random),
the probability of choosing a point belonging to each part is equal.

#### Example 2 - when biases are not equal

* let `$array` be `['a', 'b', 'c', 'd']`
* let `$biases` all be equal -  `[1.0, 0.5, 1.0, 3.0]`

Then the range should look like this:

<div class="br-chart-element" style="width: 18%; background-color: #f2ca19;">a</div>
<div class="br-chart-element" style="width: 9%; background-color: #87e911;">b</div>
<div class="br-chart-element" style="width: 18%; background-color: #ff00bd;">c</div>
<div class="br-chart-element" style="width: 54%; background-color: #88c6ed;">d</div>

Please note, that:

* width of `a` and `c` are equal
* width of `b` if half the width of `a` or `c`
* width of `d` if triple the width of `a` or `c`

Now we can clearly see, that if we pick a random point from this range
(using a normal, unbiased random), the **probability of choosing a point belonging to each
part is not equal anymore - it's proportional to the biases**. And this is exactly what we want.

#### Summary: so how getBiasedRandomIndex works

1. First `getBiasedRandomIndex` creates a range by summing all the biases and remembering the borders
   between each part in `$rightRangeBordersExclusive` array (lines 13-18).
2. Then it picks a random point from this range - line 20
3. Finally, it checks to which part the point belongs and returns the index of this part (lines 22-26)
