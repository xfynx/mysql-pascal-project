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
    write('id ����������':15);
    write('��������':15);
    write('�����':15);
    write('������':15);
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
    write('������� ����� ����� (��� ���������� ��� ������������ ���� ����� �����������): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id ����������':15);
    write(textFile, '��������':15);
    write(textFile, '�����':15);
    writeln(textFile, '������':15);
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
  write('�������� ����������: ');
  readln(name);
  write('������: ');
  readln(country);
  write('��������� �����: ');
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
  write('����� ����������: ');
  readln(id);
  write('�������� ����������: ');
  readln(name);
  write('������: ');
  readln(country);
  write('��������� �����: ');
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
  write('����� ����������: ');
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
        write('����� ����������: '); readln(id_lib);
        write('��������: '); readln(name);
        write('�����: '); readln(author);
        write('�����: '); readln(series);
        write('����������: '); readln(counts);
        write('��� �������: '); readln(years);
        write('��� ��������: '); readln(id_pub);
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
        write('��� �����: '); readln(id_book);
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
        write('����� �����: '); readln(id_book);
        write('����� ����������: '); readln(id_lib);
        write('��������: '); readln(name);
        write('�����: '); readln(author);
        write('�����: '); readln(series);
        write('����������: '); readln(counts);
        write('��� �������: '); readln(years);
        write('��� ��������: '); readln(id_pub);
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
        writeln('id �����: ');
        readln(id_book);
        query.CommandText := 'select * from books where id_book like ' + id_book; 
      end;
    6: 
      begin
        writeln('�����: ');
        readln(series);
        query.CommandText := 'select * from books where series like ''' + series + '''';
      end;
    7: 
      begin
        writeln('�����: ');
        readln(author);
        query.CommandText := 'select * from books where author like ''' + author + '''';
      end;
    8: 
      begin
        writeln('��������: ');
        readln(name);
        query.CommandText := 'select * from books where name like ''' + name + '''';
      end;
    9: 
      begin
        writeln('��� ��������: ');
        readln(id_pub);
        query.CommandText := 'select * from books where id_pub = ' + id_pub;
      end;
    10: 
      begin
        writeln('��� �������: ');
        readln(years);
        query.CommandText := 'select * from books where years = ' + years;
      end;
  end;
  query.Connection := connect;
  connect.Open();
  MyReader := query.ExecuteReader();
  if flag then begin
    write('id ����������':15);
    write('��������':15);
    write('�����':15);
    write('�����':15);
    write('����������':15);
    write('��� �������':15);
    write('��� ��������':15);
    write('��� �����':15);
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
    write('������� ����� ����� (��� ���������� ��� ������������ ���� ����� �����������): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id ����������':15);
    write(textFile, '��������':15);
    write(textFile, '�����':15);
    write(textFile, '�����':15);
    write(textFile, '����������':15);
    write(textFile, '��� �������':15);
    write(textFile, '��� ��������':15);
    writeln(textFile, '��� �����':15);
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
        write('��������: '); readln(name);
        write('�����: '); readln(adress);
        write('�������: '); readln(phone);
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
        write('��� ��������: '); readln(id_pub);
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
        write('��� ��������: '); readln(id_pub);
        write('��������: '); readln(name);
        write('�����: '); readln(adress);
        write('�������: '); readln(phone);
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
    write('id ��������':15);
    write('��������':15);
    write('�����':15);
    writeln('�������':15);
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
    write('������� ����� ����� (��� ���������� ��� ������������ ���� ����� �����������): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, 'id ��������':15);
    write(textFile, '��������':15);
    write(textFile, '�����':15);
    writeln(textFile, '�������':15);
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
        write('�������: '); readln(fam);
        query.CommandText := 'select * from readers where fam like ''' + fam + ''';';
      end;
    3:
      begin
        write('����� ������������� ������: '); readln(id_ticket);
        query.CommandText := 'select * from readers where id_ticket like ' + id_ticket + ';';
      end;
    4: 
      begin
        write('���: '); readln(nam);
        write('�������: '); readln(fam);
        writeln('���� ��������.');
        write('���: '); readln(temp); birth := temp + '-';
        write('�����: '); readln(temp); birth := birth + temp + '-';
        write('����: '); readln(temp); birth := birth + temp;
        write('�����: '); readln(adress);
        write('�������: '); readln(phone);
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
        write('����� ������������� ������: '); readln(id_ticket);
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
        write('����� ������������� ������: '); readln(id_ticket);
        write('���: '); readln(nam);
        write('�������: '); readln(fam);
        write('�����: '); readln(adress);
        write('�������: '); readln(phone);
        writeln('���� ��������.');
        write('���: '); readln(temp); birth := temp + '-';
        write('�����: '); readln(temp); birth := birth + temp + '-';
        write('����: '); readln(temp); birth := birth + temp;
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
    write('����� ��������':20);
    write('�������':20);
    write('���':20);
    write('�����':20);
    write('���� ��������':20);
    writeln('�������':20);
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
    write('������� ����� ����� (��� ���������� ��� ������������ ���� ����� �����������): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, '����� ��������':20);
    write(textFile, '�������':20);
    write(textFile, '���':20);
    write(textFile, '�����':20);
    write(textFile, '���� ��������':20);
    writeln(textFile, '�������':20);
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
        write('����� ����������: '); readln(id_lib);
        query.CommandText := 'select * from returns where id_lib like ''' + id_lib + ''';';
      end;
    3:
      begin
        write('����� ������������� ������: '); readln(id_ticket);
        query.CommandText := 'select * from returns where id_ticket like ' + id_ticket + ';';
      end;
    4: 
      begin
        write('����� ������������� ������: '); readln(id_ticket);
        write('����� ����������: '); readln(id_lib);
        write('����� �����: '); readln(id_book);
        writeln('���� ������.');
        write('���: '); readln(temp); issues := temp + '-';
        write('�����: '); readln(temp); issues := issues + temp + '-';
        write('����: '); readln(temp); issues := issues + temp;
        writeln('���� ��������.');
        write('���: '); readln(temp); returns := temp + '-';
        write('�����: '); readln(temp); returns := returns + temp + '-';
        write('����: '); readln(temp); returns := returns + temp;
        writeln('�������� ���� ��������.');
        write('���: '); readln(temp); real_returns := temp + '-';
        write('�����: '); readln(temp); real_returns := real_returns + temp + '-';
        write('����: '); readln(temp); real_returns := real_returns + temp;
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
        write('����� ������-��������: '); readln(id_return);
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
        write('����� ������-��������: '); readln(id_return);
        write('����� ������������� ������: '); readln(id_ticket);
        write('����� ����������: '); readln(id_lib);
        write('����� �����: '); readln(id_book);
        writeln('���� ������.');
        write('���: '); readln(temp); issues := temp + '-';
        write('�����: '); readln(temp); issues := issues + temp + '-';
        write('����: '); readln(temp); issues := issues + temp;
        writeln('���� ��������.');
        write('���: '); readln(temp); returns := temp + '-';
        write('�����: '); readln(temp); returns := returns + temp + '-';
        write('����: '); readln(temp); returns := returns + temp;
        writeln('�������� ���� ��������.');
        write('���: '); readln(temp); real_returns := temp + '-';
        write('�����: '); readln(temp); real_returns := real_returns + temp + '-';
        write('����: '); readln(temp); real_returns := real_returns + temp;
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
    write('����� ��������':15);
    write('����� �����':15);
    write('������':20);
    write('�������':20);
    write('�������� �������':20);
    write('����� ������-��������':20);
    write('����� ����������':15);
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
    write('������� ����� ����� (��� ���������� ��� ������������ ���� ����� �����������): ');
    readln(path);
    assign(textFile, path);
    rewrite(textFile);
    write(textFile, '����� ��������':15);
    write(textFile, '����� �����':15);
    write(textFile, '������':20);
    write(textFile, '�������':20);
    write(textFile, '�������� �������':20);
    write(textFile, '����� ������-��������':20);
    writeLn(textFile, '����� ����������':15);
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
    writeln('�������� ��������:');
    writeln('1 - ����������');
    writeln('2 - �����');
    writeln('3 - ��������');
    writeln('4 - ��������� ���������');
    writeln('5 - ���������� � �������-��������� ����');
    if consoleWriter then writeln('10 - �������� � ����') else writeln('10 - �������� �����');
    writeln('0 - ����� �� ���������');
    readln(n);
    writeln('---------------------------------------------------------------------------');
    case n of
      1: 
        begin
          writeln('1 - ����� ���������� � �����������');
          writeln('2 - ���������� ����� ���������� � ����');
          writeln('3 - �������� ���������� �� ������');
          writeln('4 - ���������� ���������� � ��������� ����������');
          writeln('0 - ����� � ������� ����');
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
          writeln('1 - ����� ���������� � ������ � ��������� ����������');
          writeln('2 - ���������� ����� ����� � ������� ����������');
          writeln('3 - �������� ����� �� ������');
          writeln('4 - ���������� ���������� � ��������� �����');
          writeln('5 - ����� ���������� � ��������� �����');
          writeln('6 - ����� �� �����');
          writeln('7 - ����� �� ������');
          writeln('8 - ����� �� ��������');
          writeln('9 - ����� �� ���� ��������');
          writeln('10 - ����� �� ���� �������');
          writeln('0 - ����� � ������� ����');
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
          writeln('1 - ����� ���������� �� ���������');
          writeln('2 - ����� ��������');
          writeln('3 - �������� ��������');
          writeln('4 - ���������� ���������� � ��������� ��������');
          writeln('0 - ����� � ������� ����');
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
          writeln('1 - ����� ���������� � ���� ������������������ ���������');
          writeln('2 - ����� �� �������');
          writeln('3 - ����� �� ������ ������');
          writeln('4 - ����� ��������');
          writeln('5 - �������� ��������');
          writeln('6 - ���������� ���������� � ��������� ��������');
          writeln('0 - ����� � ������� ����');
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
          writeln('1 - ����� ���������� � ���� ������� � ���������');
          writeln('2 - ������-�������� � ��������� ����������');
          writeln('3 - ������-�������� �� ��������� �������� ��������');
          writeln('4 - ����� ������-�������');
          writeln('5 - �������� ����������');
          writeln('6 - ���������� ���������� � ������-��������');
          writeln('0 - ����� � ������� ����');
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
          write('���������� �������� ����� ���������� � '); 
          if consoleWriter then write('�������') else writeln('����');
        end;
      0:
        begin
          flag := false; writeln('�� �������!')
        end;
    else
      writeln( '������� �� ����������. ��������� ����.');
    end;
    writeln('---------------------------------------------------------------------------');
  end;
end.