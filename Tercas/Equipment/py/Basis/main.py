import sys
from PySide6.QtSql import QSqlDatabase, QSqlTableModel
from PySide6.QtCore import (
    Qt, 
    QRect, 
    QModelIndex, 
    QSize
)
from PySide6.QtWidgets import (
    QApplication,
    QMainWindow,
    QTableView,
    QMessageBox,
    QStyledItemDelegate,
    QHeaderView,
    QStyle
)
from PySide6.QtGui import (
    QPainter,
    QTextDocument,
    QTextOption,
    QAbstractTextDocumentLayout
)


class MultilineTextDelegate(QStyledItemDelegate):
    def paint(self, painter, option, index):
        painter.save()

        # Initialize style options (handles selected states and backgrounds)
        self.initStyleOption(option, index)

        # Prepare the text document
        doc = QTextDocument()
        doc.setHtml(option.text) # or doc.setPlainText(option.text)

        # Enable word wrap and set the text width to match the cell's rectangle
        doc.setTextWidth(option.rect.width())
        doc.setDocumentMargin(4) # Match standard margins
        option.text = "" # Clear the default text

        # Draw the default background/style (selection, focus, etc.)
        option.widget.style().drawControl(
            option.widget.style().ControlElement.CE_ItemViewItem,
            option,
            painter,
            option.widget
        )

        # Center or align text vertically/horizontally
        ctx = QAbstractTextDocumentLayout.PaintContext()
        if option.state & QStyle.StateFlag.State_Selected:
            ctx.pallete.setColor(doc.foregroundRole(), option.pallete.highlightedText().color())

        painter.translate(option.rect.x(), option.rect.y())

        # Simple vertical centering (if the cell is taller than the text)
        available_height = option.rect.height() - doc.size().height()
        if available_height > 0:
            painter.translate(0, available_height / 2)

        # Draw the multiline document
        doc.documentLayout().draw(painter, ctx)

        painter.restore()

    def sizeHint(self, option, index):
        # Calculate size hint based on the wrapped document height
        size = super().sizeHint(option, index)
        doc = QTextDocument()
        doc.setHtml(index.data())
        doc.setTextWidth(option.rect.width())
        doc.setDocumentMargin(4)
        return QSize(size.width(), int(doc.size().height()))


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

        delegate = MultilineTextDelegate(self.table_view)
        self.table_view.setItemDelegateForColumn(1, delegate)

        # Crucial: Enable row resizing to allow multiline cells to grow
        self.table_view.verticalHeader().setSectionResizeMode(QHeaderView.ResizeMode.ResizeToContents)

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