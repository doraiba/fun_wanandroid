void main() {
  // Future.microtask(computation)
  int a = 0;
  Future.doWhile(() {
    print('--$a');
    return Future.delayed(Duration(milliseconds: 300), () => a == 0);
  }).then((_)=>333).then((_) => print('======$_ and $a'));

  Future.delayed(Duration(seconds: 2)).then((_) {
    print(++a);
  });

  print('helloworld');
}
