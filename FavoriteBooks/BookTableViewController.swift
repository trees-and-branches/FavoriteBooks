import UIKit

class BookTableViewController: UITableViewController {
   

    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
            

        let book = books[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = book.title
//        content.secondaryText = book.description
//        cell.contentConfiguration = content
        cell.update(with: book)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    // MARK: - Navigation
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let source = segue.source as? BookFormTableViewController,
            let book = source.book else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath.row)
            books.remove( at: indexPath.row)
            books.insert(book, at: indexPath.row) // this is where books are edited (removed and replaced)
            print(indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            books.append(book) // this is where new books are added
        }
    }
    
    
    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
    
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        let book = books[indexPath.row]
        
        return BookFormTableViewController(coder: coder, book: book)
    }
    
    
}
