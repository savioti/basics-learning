use std::collections::HashMap;

fn main() {
    let action = std::env::args().nth(1).expect("Please specify an action");
    let mut item = String::new();

    if action != "clear" {
        item = std::env::args().nth(2).expect("Please specify an item");
    }

    let mut todo = Todo::new().expect("Error while creating or reading file.");

    if action == "add" {
        todo.insert_todo_item(item);
        match todo.save_to_file() {
            Ok(_) => println!("Item saved!"),
            Err(why) => println!("An error ocurred: {}", why),
        }
    } else if action == "complete" {
        match todo.complete(&item) {
            None => println!("'{}' was not found.", item),
            Some(_) => match todo.save_to_file() {
                Ok(_) => println!("todo saved"),
                Err(why) => println!("An error ocurred: {}", why),
            },
        }
    } else if action == "clear" {
        todo.clear();
        match todo.save_to_file() {
            Ok(_) => println!("todo saved"),
            Err(why) => println!("An error ocurred: {}", why),
        }
    }
}

struct Todo {
    map: HashMap<String, String>,
}

impl Todo {
    fn new() -> Result<Todo, std::io::Error> {
        let file = std::fs::OpenOptions::new()
            .write(true)
            .create(true)
            .read(true)
            .open("output/db.json")?;
        // let mut file_content = String::new();

        match serde_json::from_reader(file) {
            Ok(map) => Ok(Todo { map }),
            Err(e) if e.is_eof() => Ok(Todo {
                map: HashMap::new(),
            }),
            Err(e) => panic!("An error occurred {}", e),
        }

        // file.read_to_string(&mut file_content)?;

        // let map = file_content
        //     .lines()
        //     .map(|line| line.splitn(2, '\t').collect::<Vec<&str>>())
        //     .map(|v| (v[0], v[1]))
        //     .map(|(k, v)| (String::from(k), String::from(v)))
        //     .collect::<HashMap<String, String>>();
        // Ok(Todo { map })
    }

    fn insert_todo_item(&mut self, key: String) {
        self.map.insert(key, String::from("PENDING"));
    }

    fn complete(&mut self, key: &String) -> Option<()> {
        match self.map.get_mut(key) {
            Some(v) => Some(*v = String::from("DONE")),
            None => None,
        }
    }

    fn clear(&mut self) {
        self.map.clear();
    }

    fn save_to_file(self) -> Result<(), std::io::Error> {
        // let mut content = String::new();

        // for (k, v) in self.map {
        //     let record = format!("{}\t{}\n", k, v);
        //     content.push_str(&record)
        // }

        // std::fs::write("output/db.txt", content)
        let file = std::fs::OpenOptions::new()
            .write(true)
            .create(true)
            .read(true)
            .open("output/db.json")?;

        serde_json::to_writer_pretty(file, &self.map)?;
        Ok(())
    }
}
