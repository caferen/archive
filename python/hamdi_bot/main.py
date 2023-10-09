import nltk
from nltk.stem.porter import PorterStemmer
import numpy


# create stemmer
stemmer = PorterStemmer()

# tokenize the sentence
def tokenize(sentence):
    return nltk.word_tokenize(sentence)

# stem the tokenized words
def stem(word):
    return stemmer.stem(word.lower())


def bag_of_words(tokenized_sentence, all_words):
    tokenized_sentence = [stem(w) for w in tokenized_sentence]

    bag = numpy.zeros(len(all_words), dtype=numpy.float32)
    for index, w in enumerate(all_words):
        if w in tokenized_sentence:
            bag[index] = 1.0

    return bag