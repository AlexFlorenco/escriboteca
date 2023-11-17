import 'dart:io';

void main() {
  stdout.write(
      'Este algoritmo irá calcular o somatório de todos os números inteiros positivos que sejam divisíveis por 3 ou 5, menores que um número de sua escolha.\n');
  stdout.write('Digite um número inteiro positivo: ');

  try {
    int numero = int.parse(stdin.readLineSync()!);
    if (numero < 0) {
      print('Erro: O número deve ser positivo');
    } else {
      int somatorio = somatorioDivisiveisPor3ou5(numero);
      print('Somatório: $somatorio');
    }
  } catch (e) {
    print('Erro: $e');
  }
}

int somatorioDivisiveisPor3ou5(int numero) {
  int somatorio = 0;
  for (int i = 0; i < numero; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      somatorio += i;
    }
  }
  return somatorio;
}
