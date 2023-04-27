package store

import (
	"context"

	"github.com/JunNishimura/go_todo_app/entity"
)

func (r *Repository) AddTask(ctx context.Context, db Execer, t *entity.Task) error {
	t.Created = r.Clocker.Now()
	t.Modified = r.Clocker.Now()
	sql := `INSERT INTO task (title, status, created, modified) values (?, ?, ?, ?)`
	result, err := db.ExecContext(ctx, sql, t.Title, t.Status, t.Created, t.Modified)
	if err != nil {
		return err
	}
	id, err := result.LastInsertId()
	if err != nil {
		return err
	}
	t.ID = entity.TaskID(id)
	return nil
}
