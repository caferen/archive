import tweepy
import config
from flask import Flask
from flask import request
import nltk
import re

app = Flask(__name__)


@app.route('/tweets', methods=['POST'])
def tweets():
    nltk.download('stopwords')
    nltk.download('punkt')

    auth = tweepy.OAuthHandler(config.consumer_key, config.consumer_secret)
    auth.set_access_token(config.access_token_key, config.access_token_secret)
    api = tweepy.API(auth)

    hashtag = request.get_json()['search'].replace(' ', '')

    if (hashtag[0] != '#'):
        hashtag = '#' + hashtag

    tweets = api.search(hashtag, lang='en', count=100)

    favoriteTweets = api.search(
        hashtag, lang='en', result_type='popular', count=10)

    print(len(favoriteTweets), len(tweets))

    tweets = favoriteTweets + tweets

    counts = {}
    token_list = []
    ids = []
    result = []
    stop_words = nltk.corpus.stopwords.words('english') + ['https', 'rt', 'co']
    i = 0

    for tweet in tweets:
        tokens = nltk.word_tokenize(
            re.sub('[^A-Za-z0-9]+', ' ', tweet.text.lower()))
        for token in tokens:
            if('@' in token):
                continue
            if (token not in stop_words):
                token_list.append(token)

    for fav in favoriteTweets:
        if (i <= 10):
            ids.append(fav.id_str)
            i += 1

    for token in token_list:
        if token in counts:
            counts[token] += 1
        else:
            counts[token] = 1

    for key in counts:
        result.append({'text': key, 'value': counts[key]})

    if(len(result) > 50):
        result = result[0:50]

    sorted(result, key=lambda i: i['value'], reverse=True)

    return {'words': result, 'favorites': ids}
