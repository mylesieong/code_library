# Overview of AI

## Game playing
Game playing studies that interaction among more than 1 agent.
Famous algorithm are: 
* Minimax decision 
* Iterative Deepening

### Problem to be solved
Assume every player plays perfectly, and the information is complete and static

## State Search
State search is a very generic topic, state statement can apply to lots of practical problem in real life such as ""Trip Planning"",  ""Sudoku/puzzle solving"", ""Finding best strategy"" and a lot more. 
Famous algorithm are:
* BFS/ DFS 
* BFS+ (Uniform cost search)
* A star search

### Problem to be solving
When there are local max, search algorithm will be trapped so we might introduce random algorithm.

# Hidden Markov Model

## High Level Intro
Hidden Markov Model(HMM) is the very basic and widely-used methodology in AI(especially the Machine Learning Sub domain). The basic idea is build a model that consists of several states with path weights(probability). This model is then capable of "discribing" a state changing pattern. When we want to identify whether a new signal matches the known pattern, we will use the well-trained models to calculate the P( NewSignal | HMM1 ) and P( NewSignal | HMM2 ). If the P(N|HMM1) is big than P(N|HMM2), then we assume that NewSignal is following the patterm that HMM1 is describing.

## HMM Training
* Expectation Maximizing: This is the basic method of training a model. The basic steps are:
    1. define k state
    2. get n samples to train the model
    3. place k - 1 separation into each sample
    4. calc the gaussian distribution signature (standard deviation and mean) for each state based on separated samples
    5. use the distribution to move the separation to a more likely position
    6. loop back to step 4 until the convergence
    7. Lastly, compute the state link probability based on the final separation.

* Baum Welch Algorithm: 
This is an algorithm that improve the model trained with the expectation maximizing method. This main idea is to allow all sample data point affect the distribution building with assigning weight. It's proven to be effective.

## Calculating P(N|HMM)
To understand P(N|HMM), say HMM is trained from Ni samples. And we use the model to generate No samples. If Ni and No are big enough, these 2 sample set will converge to an identical set. Under this scenario, then P(N|HMM) means the probability that N appears in the converged sample set. 
