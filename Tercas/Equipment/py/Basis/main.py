import sys
from PySide6.QtCore import Qt
from PySide6.QtSql import QSqlDatabase, QSqlTableModel
from PySide6.QtWidgets import (
    QApplication,
    QMainWindow,
    QTableView,
    QMessageBox
)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Basis Database")
        self.resize(2000, 1200)

        if not self.db_connect():
            sys.exit(1)

        self.model = QSqlTableModel(self)
        self.model.setTable("equipment.basis")
        self.model.setEditStrategy(QSqlTableModel.EditStrategy.OnManualSubmit)
        self.model.select()

        self.table_view = QTableView()
        self.table_view.setModel(self.model)
        self.table_view.resizeColumnsToContents()

        self.table_view.setColumnWidth(1, 1000)

        self.setCentralWidget(self.table_view)


    def db_connect(self):
        db = QSqlDatabase.addDatabase("QPSQL")

        db.setHostName("217.107.219.91")
        db.setDatabaseName("tercas")
        db.setUserName("postgres")
        db.setPassword("monrepo")
        db.setPort(5432)

        if not db.open():
            QMessageBox.critical(
                self,
                "Database Error",
                f"Could not connect to PostgreSQL: { db.lastError().text() }"
            )
            return False
        return True


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
     
    sys.exit(app.exec())