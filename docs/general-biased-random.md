# Biased random algorithm

Choosing random elements from an array without repetitions is generally a typical programming task.
But what if we would like to have randomness, but with some influence on how this randomness works?

This is my solution for **the biased random problem** - selecting random array elements with the
ability to adjust the likelihood of each element being chosen.

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

* `$array` is an array of elements of any type. 
This will be the array from which we will choose the elements
* `$biases` an array of floats matching `$array`'s size. Each element of `$biases` should
  define the probability of choosing corresponding item from `$array`, where:
    * 1.0 is the standard probability, 
    * values below 1.0 reduce the likelihood, 
    * 0.0 means the element can’t be chosen, 
    * values above 1.0 increase the likelihood.
    * negative values are not allowed
* `$count` is the number of elements to select.

### Example

Given `$array = ['a', 'b', 'c', 'd']`, `$biases = [1.0, 0.5, 1.0, 3.0]`, and `$count = 2`:

* The probability of selecting `'b'` is halved compared to `'a'` or `'c'` (factor 0.5).
* The probability of selecting `'d'` is three times higher than `'a'` or `'c'` (factor 3.0).

### Real-life example

Some example of where can we use the biased random algorithm is the multiplication
table quiz app for primary school kids:

> The application should ask a few random question about the multiplication
> table and verify the student's answer.
>
> ![memo.png](resources%2Fmemo.png)
>
> The problem is that the multiplication table contains some very simple operations
> (like multiplying by `0`, `1` or `10`), but also some more difficult to remember (like `7 * 8`)
> 
> Let's take a look:
>
> <table id="multiplication-table"></table>
> <span class="q-legend q-very-simple">very simple</span> - <span class="q-legend q-simple">simple</span> - moderate - <span class="q-legend q-difficult">difficult</span> 
>
> Of course, we can argue whether some operation is "simple", "very simple", "normal" or "difficult",
> but let's stick to the definition from the table above. We can see that there's
> more green than red in the table - **"simple" and "very simple" questions are majority,
> "difficult" - are minority**.
> 
> But if we want kids to learn,
> **the app should focus on the difficult operations**, and reduce question about the simple ones.
>
> This is where the biased random algorithm might be used. We could assign higher
> biases to "difficult" questions, making them more likely to be chosen, and 
> lower biases to the "simple" and "very simple" to make them less probable to be chosen.

## My solution

!!! question "Do you have a better idea?"

    This solution works, but maybe you have some better solution? Let me know in the comments!

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

1. PHP doesn't have a straightforward function to generate a random floating point number between 0.0 and 1.0,
   so I defined my own using PHP's built-in functions.
2. This function requires more explanation; please refer to the description below the listing.
3. In this case, we should select the entire array and simply randomize it. There's no need to use the biased random algorithm.
4. We need to make sure we won't change the input array. **This operation in not required in PHP**, because - unlike other
   languages, like Java - PHP passes arrays by value (copies them). Therefore, the input array is already a copy.
   However, I included it for clarity, especially for readers unfamiliar with PHP.
5. In the loop, select a random element from the array copy, append it to `$result`, and **remove** it from the copy to prevent duplicates.

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
