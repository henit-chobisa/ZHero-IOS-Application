import urllib.request
from bs4 import BeautifulSoup
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.stem import PorterStemmer

fetched_data = urllib.request.urlopen(input("Enter the link: "))

article_read = fetched_data.read()

article_parsed = BeautifulSoup(article_read, 'html.parser')

paragraph = article_parsed.find_all('p')
article_content = ''

for p in paragraph:
    article_content += p.text


def create_dictionary_table(text_string) -> dict:

    stop_words = set(stopwords.words("english"))

    words = word_tokenize(text_string)

    stem = PorterStemmer()

    frequency_table = {}
    for wd in words:
        wd = stem.stem(wd)
        if wd in stop_words:
            continue
        if wd in frequency_table:
            frequency_table[wd] += 1
        else:
            frequency_table[wd] = 1

    return frequency_table


def calculate_sentence_scores(sentences, frequency_table) -> dict:

    sentence_weight = {}

    for sentence in sentences:
        sentence_wordcount = (len(word_tokenize(sentence)))
        sentence_wordcount_without_stopwords = 0
        for word_weight in frequency_table:
            if word_weight in sentence.lower():
                sentence_wordcount_without_stopwords += 1
                if sentence[:7] in sentence_weight:
                    sentence_weight[sentence[:7]] += frequency_table[word_weight]
                else:
                    sentence_weight[sentence[:7]] = frequency_table[word_weight]

        sentence_weight[sentence[:7]] /= sentence_wordcount_without_stopwords

    return sentence_weight


def calculate_average_score(sentence_weight) -> float:

    sum_values = 0
    for entry in sentence_weight:
        sum_values += sentence_weight[entry]

    average_score = (sum_values/len(sentence_weight))

    return average_score


def get_article_summary(sentences, sentence_weight, threshold) -> str:
    sentence_counter = 0
    article_summary = ''

    for sentence in sentences:
        if sentence[:7] in sentence_weight and sentence_weight[sentence[:7]] >= threshold:
            article_summary += " " + sentence
            sentence_counter += 1

    return article_summary


if __name__ == "__main__":

    frequency_table = create_dictionary_table(article_content)

    sentences = sent_tokenize(article_content)

    sentence_score = calculate_sentence_scores(sentences, frequency_table)

    threshold = calculate_average_score(sentence_score)

    article_summary = get_article_summary(sentences, sentence_score, 1.5*threshold)

    with open("summary.text", "w") as output:
        summary = sent_tokenize(article_summary)
        for line in summary:
            output.write(line+'\n')
