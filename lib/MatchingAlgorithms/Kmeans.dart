import 'dart:convert';
import 'dart:io';
import 'dart:math';

class KMeans {
  late int k;
  late int maxIteration;
  List<List<double>> allCentroids = [];
  List<List<int>> allLabels = [];

  KMeans(this.k, {this.maxIteration = 10});

  // Hàm thuật toán k-Means lấy đầu vào là một bộ dữ liệu và số lượng cluster k. Trả về tâm của k cụm
  List<List<double>> fit(List<List<double>> dataSet) {
    // Khởi tạo ngẫu nhiên k centroids
    int numFeatures = dataSet[0].length;
    List<List<double>> centroids = getRandomCentroids(numFeatures, k);
    allCentroids.addAll(centroids);
    allLabels.add([]);

    // Khởi tạo các biến iterations, oldCentroids
    int iterations = 0;
    List<List<double>>? oldCentroids;

    // Vòng lặp cập nhật centroids trong thuật toán k-Means
    while (!shouldStop(oldCentroids, centroids, iterations)) {
      // Lưu lại centroids cũ cho quá trình kiểm tra hội tụ
      oldCentroids = centroids;
      iterations++;

      // Gán nhãn cho mỗi điểm dữ liệu dựa vào centroids
      List<int> labels = getLabels(dataSet, centroids);
      allLabels.add(labels);

      // Cập nhật centroids dựa vào nhãn dữ liệu
      centroids = getCentroids(dataSet, labels, k);
      allCentroids.clear();
      allCentroids.addAll(centroids);
    }

    return centroids;
  }

  // Hàm khởi tạo centroids ngẫu nhiên
  List<List<double>> getRandomCentroids(int numFeatures, int k) {
    List<List<double>> centroids = [];
    Random random = Random();

    for (int i = 0; i < k; i++) {
      List<double> centroid = [];
      for (int j = 0; j < numFeatures; j++) {
        centroid.add(random.nextDouble());
      }
      centroids.add(centroid);
    }

    return centroids;
  }

  // Hàm này trả về nhãn cho mỗi điểm dữ liệu trong dataSet
  List<int> getLabels(
      List<List<double>> dataSet, List<List<double>> centroids) {
    List<int> labels = [];

    for (List<double> x in dataSet) {
      // Tính khoảng cách tới các centroids và cập nhật nhãn
      List<double> distances = [];
      for (List<double> centroid in centroids) {
        double distance = 0;
        for (int i = 0; i < x.length; i++) {
          distance += pow(x[i] - centroid[i], 2);
        }
        distances.add(distance);
      }

      int label = distances.indexOf(distances.reduce(min));
      labels.add(label);
    }

    return labels;
  }

  // Hàm này trả về true hoặc false nếu k-Means hoàn thành. Điều kiện k-Means hoàn thành là
  // thuật toán vượt ngưỡng số lượng vòng lặp hoặc centroids ngừng thay đổi
  bool shouldStop(List<List<double>>? oldCentroids,
      List<List<double>> centroids, int iterations) {
    if (iterations > maxIteration) {
      return true;
    }
    if (oldCentroids == null) {
      return false;
    }

    for (int i = 0; i < centroids.length; i++) {
      for (int j = 0; j < centroids[i].length; j++) {
        if (centroids[i][j] != oldCentroids[i][j]) {
          return false;
        }
      }
    }

    return true;
  }

  // Trả về tọa độ mới cho k centroids của mỗi chiều.
  List<List<double>> getCentroids(
      List<List<double>> dataSet, List<int> labels, int k) {
    List<List<double>> centroids = [];

    for (int j = 0; j < k; j++) {
      // Lấy index cho mỗi centroids
      List<int> idxJ = [];
      for (int i = 0; i < labels.length; i++) {
        if (labels[i] == j) {
          idxJ.add(i);
        }
      }

      List<double> centroidJ = [];
      for (int i = 0; i < dataSet[0].length; i++) {
        double sum = 0;
        for (int idx in idxJ) {
          sum += dataSet[idx][i];
        }
        centroidJ.add(sum / idxJ.length);
      }

      centroids.add(centroidJ);
    }

    return centroids;
  }
}

void main() {
  var arr = [0, 0, 0, 0, 0, 0];
  var values = [0, 0.5, 1];
  var result = [];

  generateCombinations(arr, values, 0, result);

  var jsonStr = jsonEncode(result);
  var file = File('assets/output.json');
  file.writeAsStringSync(jsonStr);
}

void generateCombinations(List arr, List values, int index, List result) {
  if (index == arr.length) {
    result.add(List.from(arr));
    return;
  }

  for (var value in values) {
    arr[index] = value;
    generateCombinations(arr, values, index + 1, result);
  }
}
