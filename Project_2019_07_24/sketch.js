let model;
let inputs, outputs;
let inputs_train, outputs_train;
let input_eval = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];
let output_eval = [[0,0,0,0,0,0,1,0,0,0]];

let buttonTrain, buttonTest, buttonClear;
let lossP, ratioP;

let loss, ratio;

let isClicking, clicked, isPredicting, predicted;
let drawn = [];

function setup() {
	createCanvas(400, 400);

	model = tf.sequential();
	const hidden = tf.layers.dense( {
		inputShape: [784],
		units: 32,
		activation: 'sigmoid'
	});
	const output = tf.layers.dense({
		units: 10,
		activation: 'sigmoid'
	});
	model.add(hidden);
	model.add(output);
	const optimizer = tf.train.sgd(0.2);
	model.compile({
		optimizer: optimizer,
		loss: 'meanSquaredError'
	});

	inputs = tf.tensor2d(images);
	outputs = tf.tensor2d(labels);


	inputs_train =tf.tensor2d(images_train);
	//outputs_train = tf.tensor2d(labels_train);

	loss = 1;
	ratio = -1;

	/*buttonTrain = createButton("Train the NN");
	buttonTrain.mousePressed(train);*/

	buttonTest = createButton("Tester le NN");
	buttonTest.mousePressed(predict);

	buttonClear = createButton("Clear drawing");
	buttonClear.mousePressed(() => {
		for (let i = 0 ; i < 784 ; i++) {
			drawn[i] = 0;
		}
		console.log("ok");
	});

	predcited = -1;

	for (let i = 0 ; i < 784 ; i++) {
		drawn.push(0);
	}


	tf.tidy(() => setTimeout(train, 100));
}

function train() {
	tf.tidy(() => {
		trainModel().then(results => {
			loss = results.history.loss[0];
			setTimeout(train, 100);
		});
	});
}

async function trainModel() {
	return model.fit(inputs, outputs, {
		shuffle: true,
		epochs: 1
	});
}

function predict() {
	
	//model.evaluate(tf.tensor(input_eval), tf.tensor(output_eval)).print();
	const predictions = model.predict(inputs_train);
	predictions.data().then(computeSuccess);
}

function computeSuccess(data) {
	let maxIndex, max;
	let goods = 0;
	let k = 0;
	for (let i = 0 ; i < data.length ; i += 10) {
		max = 0;
		for (let di = 0 ; di < 10 ; di++) {
			if (data[i + di] > max) {
				maxIndex = di;
				max = data[i + di];
			}
		}
		if (labels_train[k][maxIndex] == 1) {
			goods++;
		}
		k++;
	}
	ratio = 1000 * goods / data.length;
}

function mousePressed() {
	isClicking = true;
	clicked = -1;
}

function mouseReleased() {
	isClicking = false;
	clicked = -1;
}

function draw() {
	background(0);

	if (isClicking && mouseX >= 60 && mouseX <= 340 && mouseY > 120 && mouseY < 400) {
		let X = int((mouseX - 60) / 10);
		let Y = int((mouseY - 120) / 10);
		if (clicked == -1) {
			clicked = 1 - drawn[Y * 28 + X];
		}
		drawn[Y * 28 + X] = clicked;
	}

	for (let y = 0 ; y < 28 ; y++) {
		for (let x = 0 ; x < 28 ; x++) {
			if (drawn[y * 28 + x] == 1) {
				fill(255);
				rect(60 + 10 * x, 120 + 10 * y, 10, 10);
			}
		}
	}

	if (!isPredicting) {
		tf.tidy(() => {
			isPredicting = true;
			model.predict(tf.tensor2d([drawn])).data().then((data) => {
				let max, maxIndex;
				max = 0;
				for (let i = 0 ; i < 10 ; i++) {
					if (data[i] > max) {
						max = data[i];
						maxIndex = i;
					}
				}
				predicted = maxIndex;
				isPredicting = false;
			});
		});
	}

	noStroke();
	fill(255);
	textSize(17)
	textAlign(LEFT, TOP);
	if (loss < 1) {
		text("Loss : " + nf(loss, 0, 4), 15, 15);
	}
	if (ratio >= 0) {
		text("Success rate : " + nf(ratio, 0, 2) + " %", 15, 70);
	}
	if (predicted >= 0) {
		text("Prediction : " + nf(predicted, 0, 0), 205, 42);
	}
	noFill();
	stroke(255);
	rect(60, 120, 280, 280);
}