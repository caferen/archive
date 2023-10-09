if __name__ == '__main__':
    import json
    from main import tokenize, stem, bag_of_words
    import numpy
    import torch
    import torch.nn as nn
    from torch.utils.data import Dataset, DataLoader
    from model import NeuralNet
    import tqdm
    from nlp import load_dataset


    with open('intents.json', 'r') as f:
        intents = json.load(f)

    all_words = []
    tags = []
    match = []

    for intent in intents['intents']:
        tag = intent['tag']
        tags.append(tag)
        for pattern in intent['patterns']:
            tokenized_sentence = tokenize(pattern)
            all_words.extend(tokenized_sentence)
            match.append((tokenized_sentence, tag))

    ignored_words = ['?', '.', '!']
    all_words = [stem(w) for w in all_words if w not in ignored_words]
    all_words = sorted(set(all_words))
    tags = sorted(set(tags))

    match_1 = []
    match_2 = []

    for (pattern_sentence, tag) in match:
        bag = bag_of_words(pattern_sentence, all_words)
        match_1.append(bag)

        label = tags.index(tag)
        match_2.append(label)

    match_1 = numpy.array(match_1)
    match_2 = numpy.array(match_2)

    batch_size = 8
    hidden_size = 8
    output_size = len(tags)
    input_size = len(all_words)
    learning_rate = 0.001
    num_epochs = 1000

    class ChatDataset(Dataset):
        def __init__(self):
            self.n_samples = len(match_1)
            self.x_data = match_1
            self.y_data = match_2

        def __getitem__(self, index):
            return self.x_data[index], self.y_data[index]

        def __len__(self):
            return self.n_samples

    dataset = ChatDataset()
    train_loader = DataLoader(
        dataset=dataset, batch_size=batch_size, shuffle=True, num_workers=0)

    device = torch.device('cpu')
    model = NeuralNet(input_size, hidden_size, output_size)

    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

    for epoch in tqdm.trange(num_epochs):
        for (words, labels) in train_loader:
            words = words.to(device)
            labels = labels.to(device)

            outputs = model(words)
            loss = criterion(outputs, labels.type(torch.LongTensor))

            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

        loss_sum = 0
        if (epoch + 1) % 100 == 0:
            loss_sum += loss.item()

    print(f'average loss: {loss_sum/10}')

    data = {
        "model_state": model.state_dict(),
        "input_size": input_size,
        "output_size": output_size,
        "hidden_size": hidden_size,
        "all_words": all_words,
        "tags": tags,
    }

    FILE = "data.pth"
    torch.save(data, FILE)

    print(f'training complete. file saved to {FILE}')
