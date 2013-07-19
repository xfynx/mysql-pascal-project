{$reference mysql.data.dll}

uses
  MySql.Data.MySqlClient, MySql, MySql.Data;

procedure selectFromLibrary(flag: boolean);
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  textFile: text;
  path: string;
begin
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  query.CommandText := 'select * from library';
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('id библиотеки':15);
    write('название':15);
    write('город':15);
    write('страна':15);
    writeln;
    while MyReader.Read() do 
    begin
      write(MyReader.GetValue(0):15);
      write(MyReader.GetValue(1):15);
      write(MyReader.GetValue(2):15);
      write(MyReader.GetValue(3):15);
      writeln;
    end;
  end
  else
  begin
    write('введите адрес файла (при совпадении имён существующий файл будет перезаписан): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id библиотеки':15);
    write(textFile, 'название':15);
    write(textFile, 'город':15);
    writeln(textFile, 'страна':15);
    writeln(textFile, '---------------------------------------------------------------------------');
    while MyReader.Read() do 
    begin
      write(textFile, MyReader.GetValue(0):15);
      write(textFile, MyReader.GetValue(1):15);
      write(textFile, MyReader.GetValue(2):15);
      write(textFile, MyReader.GetValue(3):15);
      writeln(textFile);
    end;
    writeln(textFile, '---------------------------------------------------------------------------');
    close(textFile);
  end;
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure addNewLibrary();
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  name, city, country: string;
begin
  write('название библиотеки: ');
  readln(name);
  write('страна: ');
  readln(country);
  write('населённый пункт: ');
  readln(city);
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  query.CommandText := 'insert into library (name,city,country) values (''' + name + ''',''' + city + ''',''' + country + ''');';
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure updateLibrary();
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  name, city, country, id: string;
begin
  write('номер библиотеки: ');
  readln(id);
  write('название библиотеки: ');
  readln(name);
  write('страна: ');
  readln(country);
  write('населённый пункт: ');
  readln(city);
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  query.CommandText := 'update library set name = ''' + name + ''', city = ''' + city + ''', country = ''' + country + ''' where library.id_lib = ' + id;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure deleteLibrary();
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  n: string;
begin
  write('номер библиотеки: ');
  readln(n);
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  query.CommandText := 'delete FROM library where library.id_lib = ' + n + ';';
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure selectFromBooks(flag: boolean; selector: integer);
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  textFile: text;
  path: string;
  id_book, id_pub, id_lib, years, counts: string;
  name, author, series: string;
begin
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  case selector of
    1: query.CommandText := 'select * from books';
    2: 
      begin
        write('номер библиотеки: '); readln(id_lib);
        write('название: '); readln(name);
        write('автор: '); readln(author);
        write('серия: '); readln(series);
        write('количество: '); readln(counts);
        write('год издания: '); readln(years);
        write('код издателя: '); readln(id_pub);
        query.CommandText := 'insert into books (id_lib,name,author,series,counts,years,id_pub) values (' + id_lib + ',''' + name + ''',''' + author + ''',''' + series + ''',' + counts + ',' + years + ',' + id_pub + ');';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from books';
      end;
    3: 
      begin
        write('код книги: '); readln(id_book);
        query.CommandText := 'delete FROM books where books.id_book = ' + id_book + ';';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from books';
      end;
    4: 
      begin
        write('номер книги: '); readln(id_book);
        write('номер библиотеки: '); readln(id_lib);
        write('название: '); readln(name);
        write('автор: '); readln(author);
        write('серия: '); readln(series);
        write('количество: '); readln(counts);
        write('год издания: '); readln(years);
        write('код издателя: '); readln(id_pub);
        query.CommandText := 'update books set name = ''' + name + ''', series = ''' + series + ''', author = ''' + author + ''', id_lib = ' + id_lib + ', counts = ' + counts + ', years = ' + years + ',id_pub = ' + id_pub + ' where books.id_book = ' + id_book;
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from books';
      end;
    5: 
      begin
        writeln('id книги: ');
        readln(id_book);
        query.CommandText := 'select * from books where id_book like ' + id_book; 
      end;
    6: 
      begin
        writeln('серия: ');
        readln(series);
        query.CommandText := 'select * from books where series like ''' + series + '''';
      end;
    7: 
      begin
        writeln('автор: ');
        readln(author);
        query.CommandText := 'select * from books where author like ''' + author + '''';
      end;
    8: 
      begin
        writeln('название: ');
        readln(name);
        query.CommandText := 'select * from books where name like ''' + name + '''';
      end;
    9: 
      begin
        writeln('код издателя: ');
        readln(id_pub);
        query.CommandText := 'select * from books where id_pub = ' + id_pub;
      end;
    10: 
      begin
        writeln('год издания: ');
        readln(years);
        query.CommandText := 'select * from books where years = ' + years;
      end;
  end;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('id библиотеки':15);
    write('название':15);
    write('автор':15);
    write('серия':15);
    write('количество':15);
    write('год издания':15);
    write('код издателя':15);
    write('код книги':15);
    writeln;
    while MyReader.Read() do 
    begin
      write(MyReader.GetValue(0):15);
      write(MyReader.GetValue(1):15);
      write(MyReader.GetValue(2):15);
      write(MyReader.GetValue(3):15);
      write(MyReader.GetValue(4):15);
      write(MyReader.GetValue(5):15);
      write(MyReader.GetValue(6):15);
      write(MyReader.GetValue(7):15);
      writeln;
    end;
  end
  else
  begin
    write('введите адрес файла (при совпадении имён существующий файл будет перезаписан): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id библиотеки':15);
    write(textFile, 'название':15);
    write(textFile, 'автор':15);
    write(textFile, 'серия':15);
    write(textFile, 'количество':15);
    write(textFile, 'год издания':15);
    write(textFile, 'код издателя':15);
    writeln(textFile, 'код книги':15);
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    while MyReader.Read() do 
    begin
      write(textFile, MyReader.GetValue(0):15);
      write(textFile, MyReader.GetValue(1):15);
      write(textFile, MyReader.GetValue(2):15);
      write(textFile, MyReader.GetValue(3):15);
      write(textFile, MyReader.GetValue(4):15);
      write(textFile, MyReader.GetValue(5):15);
      write(textFile, MyReader.GetValue(6):15);
      write(textFile, MyReader.GetValue(7):15);
      writeln(textFile);
    end;
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    close(textFile);
  end;
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure selectFromPublisher(flag: boolean; selector: integer);
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  textFile: text;
  path: string;
  id_pub: string;
  name, adress, phone: string;
begin
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  case selector of
    1: query.CommandText := 'select * from publishers';
    2: 
      begin
        write('название: '); readln(name);
        write('адрес: '); readln(adress);
        write('телефон: '); readln(phone);
        query.CommandText := 'insert into publishers (name,adress,phone) values (''' + name + ''',''' + adress + ''',' + phone + ');';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from publishers';
      end;
    3: 
      begin
        write('код издателя: '); readln(id_pub);
        query.CommandText := 'delete FROM publishers where publishers.id_pub = ' + id_pub + ';';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from publishers';
      end;
    4:
      begin
        write('код издателя: '); readln(id_pub);
        write('название: '); readln(name);
        write('адрес: '); readln(adress);
        write('телефон: '); readln(phone);
        query.CommandText := 'update publishers set name = ''' + name + ''', adress = ''' + adress + ''', phone = ' + phone + ' where publishers.id_pub = ' + id_pub;
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from publishers';
      end;
  end;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('id издателя':15);
    write('название':15);
    write('адрес':15);
    writeln('телефон':15);
    writeln;
    while MyReader.Read() do 
    begin
      write(MyReader.GetValue(0):15);
      write(MyReader.GetValue(1):15);
      write(MyReader.GetValue(2):15);
      write(MyReader.GetValue(3):15);
      writeln;
    end;
  end
  else
  begin
    write('введите адрес файла (при совпадении имён существующий файл будет перезаписан): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id издателя':15);
    write(textFile, 'название':15);
    write(textFile, 'адрес':15);
    writeln(textFile, 'телефон':15);
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    while MyReader.Read() do 
    begin
      write(textFile, MyReader.GetValue(0):15);
      write(textFile, MyReader.GetValue(1):15);
      write(textFile, MyReader.GetValue(2):15);
      write(textFile, MyReader.GetValue(3):15);
      writeln(textFile);
    end;
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    close(textFile);
  end;
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure selectFromReaders(flag: boolean; selector: integer);
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  textFile: text;
  path: string;
  id_ticket: string;
  nam, fam, adress, birth, phone, temp: string;
begin
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  case selector of
    1: query.CommandText := 'select * from readers';
    2:
      begin
        write('фамилия: '); readln(fam);
        query.CommandText := 'select * from readers where fam like ''' + fam + ''';';
      end;
    3:
      begin
        write('номер читательского билета: '); readln(id_ticket);
        query.CommandText := 'select * from readers where id_ticket like ' + id_ticket + ';';
      end;
    4: 
      begin
        write('имя: '); readln(nam);
        write('фамилия: '); readln(fam);
        writeln('Дата рождения.');
        write('год: '); readln(temp); birth := temp + '-';
        write('месяц: '); readln(temp); birth := birth + temp + '-';
        write('день: '); readln(temp); birth := birth + temp;
        write('адрес: '); readln(adress);
        write('телефон: '); readln(phone);
        query.CommandText := 'insert into readers (nam,fam,birth,adress,phone) values (''' + nam + ''',''' + fam + ''',''' + birth + ''',''' + adress + ''',' + phone + ');';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from readers';
      end;
    5: 
      begin
        write('номер читательского билета: '); readln(id_ticket);
        query.CommandText := 'delete FROM readers where readers.id_ticket = ' + id_ticket + ';';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from readers';
      end;
    6:
      begin
        write('номер читательского билета: '); readln(id_ticket);
        write('имя: '); readln(nam);
        write('фамилия: '); readln(fam);
        write('адрес: '); readln(adress);
        write('телефон: '); readln(phone);
        writeln('Дата рождения.');
        write('год: '); readln(temp); birth := temp + '-';
        write('месяц: '); readln(temp); birth := birth + temp + '-';
        write('день: '); readln(temp); birth := birth + temp;
        query.CommandText := 'update readers set nam = ''' + nam + ''', fam = ''' + fam + ''', adress = ''' + adress + ''', phone = ' + phone + ', birth = ''' + birth + ''' where readers.id_ticket = ' + id_ticket;
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from readers';
      end;
  end;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('номер карточки':20);
    write('фамилия':20);
    write('имя':20);
    write('адрес':20);
    write('дата рождения':20);
    writeln('телефон':20);
    writeln;
    while MyReader.Read() do 
    begin
      write(MyReader.GetValue(0):20);
      write(MyReader.GetValue(1):20);
      write(MyReader.GetValue(2):20);
      write(MyReader.GetValue(3):20);
      write(MyReader.GetValue(4):20);
      write(MyReader.GetValue(5):20);
      writeln;
    end;
  end
  else
  begin
    write('введите адрес файла (при совпадении имён существующий файл будет перезаписан): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'номер карточки':20);
    write(textFile, 'фамилия':20);
    write(textFile, 'имя':20);
    write(textFile, 'адрес':20);
    write(textFile, 'дата рождения':20);
    writeln(textFile, 'телефон':20);
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    while MyReader.Read() do 
    begin
      write(textFile, MyReader.GetValue(0):20);
      write(textFile, MyReader.GetValue(1):20);
      write(textFile, MyReader.GetValue(2):20);
      write(textFile, MyReader.GetValue(3):20);
      write(textFile, MyReader.GetValue(4):20);
      write(textFile, MyReader.GetValue(5):20);
      writeln(textFile);
    end;
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    close(textFile);
  end;
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

procedure selectFromReturns(flag: boolean; selector: integer);
var
  query: MySqlCommand;
  connect: MySqlConnection;
  MyReader: MySqlDataReader;
  textFile: text;
  path: string;
  id_return, id_ticket, id_book, id_lib, issues, returns, real_returns, temp: string;
begin
  connect := new MySqlConnection('Database=libraries;Data Source=localhost;User Id=xfynx;Password=bushsuxx');
  query := new MySqlCommand();
  case selector of
    1: query.CommandText := 'select * from returns';
    2:
      begin
        write('номер библиотеки: '); readln(id_lib);
        query.CommandText := 'select * from returns where id_lib like ''' + id_lib + ''';';
      end;
    3:
      begin
        write('номер читательского билета: '); readln(id_ticket);
        query.CommandText := 'select * from returns where id_ticket like ' + id_ticket + ';';
      end;
    4: 
      begin
        write('номер читательского билета: '); readln(id_ticket);
        write('номер библиотеки: '); readln(id_lib);
        write('номер книги: '); readln(id_book);
        writeln('Дата выдачи.');
        write('год: '); readln(temp); issues := temp + '-';
        write('месяц: '); readln(temp); issues := issues + temp + '-';
        write('день: '); readln(temp); issues := issues + temp;
        writeln('Дата возврата.');
        write('год: '); readln(temp); returns := temp + '-';
        write('месяц: '); readln(temp); returns := returns + temp + '-';
        write('день: '); readln(temp); returns := returns + temp;
        writeln('Реальная дата возврата.');
        write('год: '); readln(temp); real_returns := temp + '-';
        write('месяц: '); readln(temp); real_returns := real_returns + temp + '-';
        write('день: '); readln(temp); real_returns := real_returns + temp;
        query.CommandText := 'insert into returns (id_ticket,id_lib,id_book,issues,returns,real_returns) values (' + id_ticket + ',' + id_lib + ',' + id_book + ',''' + issues + ''',''' + returns + ''','''+real_returns+''');';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from returns';
      end;
    5: 
      begin
        write('номер выдачи-возврата: '); readln(id_return);
        query.CommandText := 'delete FROM returns where returns.id_return = ' + id_return + ';';
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from returns';
      end;
    6:
      begin
        write('номер выдачи-возврата: '); readln(id_return);
        write('номер читательского билета: '); readln(id_ticket);
        write('номер библиотеки: '); readln(id_lib);
        write('номер книги: '); readln(id_book);
        writeln('Дата выдачи.');
        write('год: '); readln(temp); issues := temp + '-';
        write('месяц: '); readln(temp); issues := issues + temp + '-';
        write('день: '); readln(temp); issues := issues + temp;
        writeln('Дата возврата.');
        write('год: '); readln(temp); returns := temp + '-';
        write('месяц: '); readln(temp); returns := returns + temp + '-';
        write('день: '); readln(temp); returns := returns + temp;
        writeln('Реальная дата возврата.');
        write('год: '); readln(temp); real_returns := temp + '-';
        write('месяц: '); readln(temp); real_returns := real_returns + temp + '-';
        write('день: '); readln(temp); real_returns := real_returns + temp;
        query.CommandText := 'update returns set id_ticket = ' + id_ticket + ', id_lib = ' + id_lib + ', id_book = ' + id_book + ', issues = ''' + issues + ''', returns = ''' + returns + ''', real_returns = '''+real_returns+''' where returns.id_return = ' + id_return;
        query.Connection := connect;
        connect.Open();
        MyReader := query.ExecuteReader();
        MyReader.Close();
        connect.Close();
        query.CommandText := 'select * from returns';
      end;
  end;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('номер карточки':15);
    write('номер книги':15);
    write('выдача':20);
    write('возврат':20);
    write('реальный возврат':20);
    write('номер выдачи-возврата':20);
    write('номер библиотеки':15);
    writeln;
    while MyReader.Read() do 
    begin
      write(MyReader.GetValue(0):15);
      write(MyReader.GetValue(1):15);
      write(MyReader.GetValue(2):20);
      write(MyReader.GetValue(3):20);
      write(MyReader.GetValue(4):20);
      write(MyReader.GetValue(5):20);
      write(MyReader.GetValue(6):15);
      writeln;
    end;
  end
  else
  begin
    write('введите адрес файла (при совпадении имён существующий файл будет перезаписан): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'номер карточки':15);
    write(textFile, 'номер книги':15);
    write(textFile, 'выдача':20);
    write(textFile, 'возврат':20);
    write(textFile, 'реальный возврат':20);
    write(textFile, 'номер выдачи-возврата':20);
    writeLn(textFile, 'номер библиотеки':15);
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    while MyReader.Read() do 
    begin
      write(textFile, MyReader.GetValue(0):15);
      write(textFile, MyReader.GetValue(1):15);
      write(textFile, MyReader.GetValue(2):20);
      write(textFile, MyReader.GetValue(3):20);
      write(textFile, MyReader.GetValue(4):20);
      write(textFile, MyReader.GetValue(5):20);
      write(textFile, MyReader.GetValue(6):15);
      writeln(textFile);
    end;
    writeln(textFile, '-----------------------------------------------------------------------------------------------------------------------------');
    close(textFile);
  end;
  MyReader.Close();
  Query.Dispose();
  connect.Close();
end;

var
  flag, consoleWriter: boolean;
  n, m: integer;

begin
  consoleWriter := true;
  flag := true;
  while flag do 
  begin
    writeln('Выберите действие:');
    writeln('1 - Библиотеки');
    writeln('2 - книги');
    writeln('3 - издатели');
    writeln('4 - картотека читателей');
    writeln('5 - информация о выдачах-возвратах книг');
    if consoleWriter then writeln('10 - выводить в файл') else writeln('10 - выводить здесь');
    writeln('0 - выход из программы');
    readln(n);
    writeln('---------------------------------------------------------------------------');
    case n of
      1: 
        begin
          writeln('1 - вывод информации о библиотеках');
          writeln('2 - добавление новой библиотеки в базу');
          writeln('3 - удаление библиотеки из списка');
          writeln('4 - обновление информации о выбранной библиотеке');
          writeln('0 - выход в главное меню');
          readln(m);
          case m of
            1: selectFromLibrary(consoleWriter);
            2: addNewLibrary();
            3: deleteLibrary();
            4: updateLibrary();
            0: write();
          end;
        end;
      2: 
        begin
          writeln('1 - вывод информации о книгах в выбранной библиотеке');
          writeln('2 - добавление новой книги в каталог библиотеки');
          writeln('3 - удаление книги из списка');
          writeln('4 - обновление информации о выбранной книге');
          writeln('5 - вывод информации о выбранной книге');
          writeln('6 - поиск по серии');
          writeln('7 - поиск по автору');
          writeln('8 - поиск по названию');
          writeln('9 - поиск по коду издателя');
          writeln('10 - поиск по году издания');
          writeln('0 - выход в главное меню');
          readln(m);
          case m of
            1: selectFromBooks(consoleWriter, 1);
            2: selectFromBooks(consoleWriter, 2);
            3: selectFromBooks(consoleWriter, 3);
            4: selectFromBooks(consoleWriter, 4);
            5: selectFromBooks(consoleWriter, 5);
            6: selectFromBooks(consoleWriter, 6);
            7: selectFromBooks(consoleWriter, 7);
            8: selectFromBooks(consoleWriter, 8);
            9: selectFromBooks(consoleWriter, 9);
            10: selectFromBooks(consoleWriter, 10);
            0: write();
          end;
        end;
      3: 
        begin
          writeln('1 - вывод информации об издателях');
          writeln('2 - новый издатель');
          writeln('3 - удаление издателя');
          writeln('4 - обновление информации о выбранном издателе');
          writeln('0 - выход в главное меню');
          readln(m);
          case m of
            1: selectFromPublisher(consoleWriter, 1);
            2: selectFromPublisher(consoleWriter, 2);
            3: selectFromPublisher(consoleWriter, 3);
            4: selectFromPublisher(consoleWriter, 4);
            0: write();
          end;
        end;
      4:
        begin
          writeln('1 - вывод информации о всех зарегистрированных читателях');
          writeln('2 - поиск по фамилии');
          writeln('3 - поиск по номеру записи');
          writeln('4 - новый читатель');
          writeln('5 - удаление читателя');
          writeln('6 - обновление информации о выбранном читателе');
          writeln('0 - выход в главное меню');
          readln(m);
          case m of
            1: selectFromReaders(consoleWriter, 1);
            2: selectFromReaders(consoleWriter, 2);
            3: selectFromReaders(consoleWriter, 3);
            4: selectFromReaders(consoleWriter, 4);
            5: selectFromReaders(consoleWriter, 5);
            6: selectFromReaders(consoleWriter, 6);
            0: write();
          end;
        end;
      
      5:
        begin
          writeln('1 - вывод информации о всех выдачах и возвратах');
          writeln('2 - выдачи-возвраты в выбранной библиотеке');
          writeln('3 - выдачи-возвраты по выбранной карточке читателя');
          writeln('4 - новая выдача-возврат');
          writeln('5 - удаление информации');
          writeln('6 - обновление информации о выдаче-возврате');
          writeln('0 - выход в главное меню');
          readln(m);
          case m of
            1: selectFromReturns(consoleWriter, 1);
            2: selectFromReturns(consoleWriter, 2);
            3: selectFromReturns(consoleWriter, 3);
            4: selectFromReturns(consoleWriter, 4);
            5: selectFromReturns(consoleWriter, 5);
            6: selectFromReturns(consoleWriter, 6);
            0: write();
          end;
        end;
      10: 
        begin
          consoleWriter := not (consoleWriter); 
          write('Результаты запросов будут выводиться в '); 
          if consoleWriter then write('консоли') else writeln('файл');
        end;
      0:
        begin
          flag := false; writeln('До встречи!')
        end;
    else
      writeln( 'Команда не распознана. Повторите ввод.');
    end;
    writeln('---------------------------------------------------------------------------');
  end;
end.